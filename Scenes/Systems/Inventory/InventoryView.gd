class_name InventoryView extends Node

signal item_selected(item: ItemResource)
signal item_used(item: ItemResource)
signal item_dropped(item: ItemResource)

@onready var inventory_grid: GridContainer = %InventoryGrid
@onready var item_details_panel: Panel = %ItemDetailsPanel
@onready var item_name_label: Label = %ItemNameLabel
@onready var item_description_label: RichTextLabel = %ItemDescriptionLabel
@onready var item_stats_label: Label = %ItemStatsLabel
@onready var weight_progress_bar: ProgressBar = %WeightProgressBar
@onready var weight_label: Label = %WeightLabel
@onready var slots_label: Label = %SlotsLabel
@onready var use_item_button: Button = %UseItemButton
@onready var drop_item_button: Button = %DropItemButton
@onready var sort_button: Button = %SortButton
@onready var filter_button: Button = %FilterButton

var inventory_controller: InventoryController
var selected_item: ItemResource = null
var item_slot_scene: PackedScene = preload("res://Scenes/Systems/Inventory/ItemSlot.tscn")

func _ready() -> void:
    inventory_controller = get_parent()
    if inventory_controller:
        inventory_controller.inventory_changed.connect(_on_inventory_changed)
        inventory_controller.weight_changed.connect(_on_weight_changed)
        inventory_controller.item_added.connect(_on_item_added)
        inventory_controller.item_removed.connect(_on_item_removed)
    
    use_item_button.pressed.connect(_on_use_item_pressed)
    drop_item_button.pressed.connect(_on_drop_item_pressed)
    sort_button.pressed.connect(_on_sort_pressed)
    filter_button.pressed.connect(_on_filter_pressed)
    
    refresh_display()

func refresh_display() -> void:
    _clear_grid()
    _populate_grid()
    _update_ui()

func _clear_grid() -> void:
    for child in inventory_grid.get_children():
        child.queue_free()

func _populate_grid() -> void:
    if not inventory_controller:
        return
    
    var inventory = inventory_controller.get_inventory()
    for item in inventory:
        var item_slot = item_slot_scene.instantiate()
        item_slot.set_item(item)
        item_slot.item_selected.connect(_on_item_slot_selected)
        item_slot.item_used.connect(_on_item_slot_used)
        inventory_grid.add_child(item_slot)

func _update_ui() -> void:
    if not inventory_controller:
        return
    
    # Update weight display
    var current_weight = inventory_controller.get_total_weight()
    var max_weight = inventory_controller.get_max_weight()
    var weight_percentage = inventory_controller.get_weight_percentage()
    
    weight_progress_bar.max_value = max_weight
    weight_progress_bar.value = current_weight
    weight_label.text = "Weight: %.1f/%.1f" % [current_weight, max_weight]
    
    # Update slots display
    var slots_used = inventory_controller.get_slots_used()
    var max_slots = inventory_controller.get_max_slots()
    slots_label.text = "Slots: %d/%d" % [slots_used, max_slots]
    
    # Update weight bar color based on percentage
    if weight_percentage > 90:
        weight_progress_bar.modulate = Color.RED
    elif weight_percentage > 75:
        weight_progress_bar.modulate = Color.ORANGE
    elif weight_percentage > 50:
        weight_progress_bar.modulate = Color.YELLOW
    else:
        weight_progress_bar.modulate = Color.GREEN

func _on_item_slot_selected(item: ItemResource) -> void:
    selected_item = item
    _update_item_details()
    item_selected.emit(item)

func _on_item_slot_used(item: ItemResource) -> void:
    if inventory_controller:
        inventory_controller.use_item(item)
    item_used.emit(item)

func _update_item_details() -> void:
    if not selected_item:
        item_details_panel.visible = false
        return
    
    item_details_panel.visible = true
    item_name_label.text = selected_item.get_item_name()
    item_name_label.modulate = selected_item.get_rarity_color()
    
    item_description_label.text = selected_item.get_description()
    
    var stats_text = ""
    stats_text += "Type: %s\n" % selected_item.get_item_name()
    stats_text += "Rarity: %s\n" % selected_item.get_rarity().capitalize()
    stats_text += "Weight: %.1f\n" % selected_item.get_weight()
    stats_text += "Value: %d\n" % selected_item.get_value()
    stats_text += "Count: %d" % selected_item.get_count()
    
    if selected_item.is_stackable():
        stats_text += "/%d" % selected_item.get_max_stack_size()
    
    item_stats_label.text = stats_text
    
    # Enable/disable action buttons
    use_item_button.disabled = not inventory_controller.has_item(selected_item)
    drop_item_button.disabled = not inventory_controller.has_item(selected_item)

func _on_use_item_pressed() -> void:
    if selected_item and inventory_controller:
        inventory_controller.use_item(selected_item)
        item_used.emit(selected_item)

func _on_drop_item_pressed() -> void:
    if selected_item and inventory_controller:
        inventory_controller.remove_from_inventory(selected_item, 1)
        item_dropped.emit(selected_item)
        selected_item = null
        _update_item_details()

func _on_sort_pressed() -> void:
    if inventory_controller:
        inventory_controller.sort_inventory_by_name()

func _on_filter_pressed() -> void:
    # TODO: Implement filter menu
    pass

func _on_inventory_changed() -> void:
    refresh_display()

func _on_weight_changed(current_weight: float, max_weight: float) -> void:
    _update_ui()

func _on_item_added(item: ItemResource) -> void:
    # Optional: Add visual feedback for new items
    pass

func _on_item_removed(item: ItemResource) -> void:
    # Optional: Add visual feedback for removed items
    pass

func add_inventory_to_casefileui_item_vbox(i: ItemResource) -> void:
    # Legacy method for compatibility
    if inventory_controller:
        inventory_controller.add_to_inventory(i)

func _button_pressed(i: ItemResource) -> void:
    # Legacy method for compatibility
    selected_item = i
    _update_item_details()
    item_selected.emit(i)