class_name InventorySystem extends Node

signal inventory_opened()
signal inventory_closed()
signal item_added_to_inventory(item: ItemResource, success: bool)
signal item_removed_from_inventory(item: ItemResource)
signal item_used(item: ItemResource)

@export var inventory_controller: InventoryController
@export var inventory_ui: InventoryView
@export var max_weight: float = 100.0
@export var max_slots: int = 50

var is_inventory_open: bool = false
var items_resource: ItemsResource

func _ready() -> void:
    # Initialize the inventory system
    if not inventory_controller:
        inventory_controller = InventoryController.new()
        add_child(inventory_controller)
    
    if not inventory_ui:
        inventory_ui = InventoryView.new()
        add_child(inventory_ui)
    
    # Set up the items resource
    items_resource = ItemsResource.new()
    items_resource.on_load()
    
    # Configure the inventory controller
    inventory_controller.max_weight = max_weight
    inventory_controller.max_slots = max_slots
    
    # Connect signals
    _connect_signals()

func _connect_signals() -> void:
    if inventory_controller:
        inventory_controller.item_added.connect(_on_item_added)
        inventory_controller.item_removed.connect(_on_item_removed)
        inventory_controller.item_used.connect(_on_item_used)
        inventory_controller.inventory_changed.connect(_on_inventory_changed)
    
    if inventory_ui:
        inventory_ui.item_selected.connect(_on_item_selected)
        inventory_ui.item_used.connect(_on_item_used)
        inventory_ui.item_dropped.connect(_on_item_dropped)

# Public API for other systems

func open_inventory() -> void:
    if not is_inventory_open:
        is_inventory_open = true
        if inventory_ui:
            inventory_ui.visible = true
            inventory_ui.refresh_display()
        inventory_opened.emit()

func close_inventory() -> void:
    if is_inventory_open:
        is_inventory_open = false
        if inventory_ui:
            inventory_ui.visible = false
        inventory_closed.emit()

func toggle_inventory() -> void:
    if is_inventory_open:
        close_inventory()
    else:
        open_inventory()

func add_item_to_inventory(item: ItemResource) -> bool:
    if not inventory_controller:
        return false
    
    var success = inventory_controller.add_to_inventory(item)
    item_added_to_inventory.emit(item, success)
    return success

func remove_item_from_inventory(item: ItemResource, amount: int = 1) -> bool:
    if not inventory_controller:
        return false
    
    return inventory_controller.remove_from_inventory(item, amount)

func use_item(item: ItemResource) -> bool:
    if not inventory_controller:
        return false
    
    return inventory_controller.use_item(item)

func has_item(item: ItemResource) -> bool:
    if not inventory_controller:
        return false
    
    return inventory_controller.has_item(item)

func has_item_by_guid(guid: String) -> bool:
    if not inventory_controller:
        return false
    
    return inventory_controller.has_item_by_guid(guid)

func get_item_by_guid(guid: String) -> ItemResource:
    if not inventory_controller:
        return null
    
    return inventory_controller.get_item_by_guid(guid)

func get_inventory_items() -> Array[ItemResource]:
    if not inventory_controller:
        return []
    
    return inventory_controller.get_inventory()

func get_available_items() -> Array[ItemResource]:
    return items_resource.get_items_as_resources()

func get_items_by_type(item_type: String) -> Array[ItemResource]:
    if not inventory_controller:
        return []
    
    return inventory_controller.get_items_by_type(item_type)

func get_items_by_rarity(rarity: String) -> Array[ItemResource]:
    if not inventory_controller:
        return []
    
    return inventory_controller.get_items_by_rarity(rarity)

func get_total_weight() -> float:
    if not inventory_controller:
        return 0.0
    
    return inventory_controller.get_total_weight()

func get_weight_percentage() -> float:
    if not inventory_controller:
        return 0.0
    
    return inventory_controller.get_weight_percentage()

func get_slots_used() -> int:
    if not inventory_controller:
        return 0
    
    return inventory_controller.get_slots_used()

func get_slots_available() -> int:
    if not inventory_controller:
        return 0
    
    return inventory_controller.get_slots_available()

func can_add_item(item: ItemResource) -> bool:
    if not inventory_controller:
        return false
    
    return inventory_controller.can_add_item(item)

func clear_inventory() -> void:
    if inventory_controller:
        inventory_controller.clear_inventory()

func save_inventory() -> Dictionary:
    if not inventory_controller:
        return {}
    
    return inventory_controller.save_inventory()

func load_inventory(save_data: Dictionary) -> void:
    if inventory_controller:
        inventory_controller.load_inventory(save_data)

func create_item_from_template(template_name: String) -> ItemResource:
    return items_resource.create_item_from_template(template_name)

func create_custom_item(name: String, description: String = "", item_type: String = "misc",
                       rarity: String = "common", weight: float = 0.0, value: int = 0,
                       max_stack: int = 99, stackable: bool = true) -> ItemResource:
    return items_resource.create_custom_item(name, description, item_type, rarity, weight, value, max_stack, stackable)

func search_items(search_term: String) -> Array[ItemResource]:
    return items_resource.search_items(search_term)

func sort_inventory_by_name() -> void:
    if inventory_controller:
        inventory_controller.sort_inventory_by_name()

func sort_inventory_by_value() -> void:
    if inventory_controller:
        inventory_controller.sort_inventory_by_value()

func sort_inventory_by_weight() -> void:
    if inventory_controller:
        inventory_controller.sort_inventory_by_weight()

# Signal handlers

func _on_item_added(item: ItemResource) -> void:
    if inventory_ui:
        inventory_ui.refresh_display()

func _on_item_removed(item: ItemResource) -> void:
    if inventory_ui:
        inventory_ui.refresh_display()
    item_removed_from_inventory.emit(item)

func _on_item_used(item: ItemResource) -> void:
    item_used.emit(item)

func _on_inventory_changed() -> void:
    if inventory_ui:
        inventory_ui.refresh_display()

func _on_item_selected(item: ItemResource) -> void:
    # Handle item selection (could be used for tooltips, etc.)
    pass

func _on_item_dropped(item: ItemResource) -> void:
    # Handle item dropping (could spawn item in world, etc.)
    pass

# Input handling

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("inventory"):
        toggle_inventory()
    
    if event.is_action_pressed("ui_cancel") and is_inventory_open:
        close_inventory()

# Utility functions

func get_inventory_summary() -> Dictionary:
    var summary = {
        "total_items": 0,
        "total_weight": 0.0,
        "total_value": 0,
        "slots_used": 0,
        "slots_available": 0,
        "items_by_type": {},
        "items_by_rarity": {}
    }
    
    if not inventory_controller:
        return summary
    
    var items = inventory_controller.get_inventory()
    summary.total_items = items.size()
    summary.total_weight = inventory_controller.get_total_weight()
    summary.slots_used = inventory_controller.get_slots_used()
    summary.slots_available = inventory_controller.get_slots_available()
    
    for item in items:
        summary.total_value += item.get_total_value()
        
        # Count by type
        var item_type = item.get_item_type()
        if not summary.items_by_type.has(item_type):
            summary.items_by_type[item_type] = 0
        summary.items_by_type[item_type] += item.get_count()
        
        # Count by rarity
        var rarity = item.get_rarity()
        if not summary.items_by_rarity.has(rarity):
            summary.items_by_rarity[rarity] = 0
        summary.items_by_rarity[rarity] += item.get_count()
    
    return summary
