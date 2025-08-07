class_name ItemSlot extends Control

signal item_selected(item: ItemResource)
signal item_used(item: ItemResource)
signal item_dropped(item: ItemResource)

@onready var item_icon: TextureRect = %ItemIcon
@onready var item_name_label: Label = %ItemNameLabel
@onready var count_label: Label = %CountLabel
@onready var background_panel: Panel = %BackgroundPanel
@onready var tooltip_panel: Panel = %TooltipPanel
@onready var tooltip_label: Label = %TooltipLabel

var current_item: ItemResource = null
var is_selected: bool = false

func _ready() -> void:
    mouse_entered.connect(_on_mouse_entered)
    mouse_exited.connect(_on_mouse_exited)
    gui_input.connect(_on_gui_input)
    
    # Set up tooltip
    tooltip_panel.visible = false

func set_item(item: ItemResource) -> void:
    current_item = item
    _update_display()

func get_item() -> ItemResource:
    return current_item

func _update_display() -> void:
    if not current_item:
        _clear_display()
        return
    
    # Set item name
    item_name_label.text = current_item.get_item_name()
    item_name_label.modulate = current_item.get_rarity_color()
    
    # Set count
    if current_item.get_count() > 1:
        count_label.text = str(current_item.get_count())
        count_label.visible = true
    else:
        count_label.visible = false
    
    # Set icon (placeholder for now)
    # TODO: Load actual item icon from item_data
    item_icon.texture = null
    
    # Set background based on rarity
    _update_background()

func _clear_display() -> void:
    item_name_label.text = ""
    count_label.visible = false
    item_icon.texture = null
    background_panel.modulate = Color.GRAY

func _update_background() -> void:
    if not current_item:
        background_panel.modulate = Color.GRAY
        return
    
    var rarity_color = current_item.get_rarity_color()
    background_panel.modulate = rarity_color
    background_panel.modulate.a = 0.3  # Make it semi-transparent

func set_selected(selected: bool) -> void:
    is_selected = selected
    if selected:
        background_panel.modulate = Color.YELLOW
        background_panel.modulate.a = 0.5
    else:
        _update_background()

func _on_mouse_entered() -> void:
    if current_item:
        tooltip_panel.visible = true
        _update_tooltip()

func _on_mouse_exited() -> void:
    tooltip_panel.visible = false

func _update_tooltip() -> void:
    if not current_item:
        return
    
    var tooltip_text = ""
    tooltip_text += "[b]%s[/b]\n" % current_item.get_item_name()
    tooltip_text += "%s\n" % current_item.get_description()
    tooltip_text += "Type: %s\n" % current_item.get_item_type().capitalize()
    tooltip_text += "Rarity: %s\n" % current_item.get_rarity().capitalize()
    tooltip_text += "Weight: %.1f\n" % current_item.get_weight()
    tooltip_text += "Value: %d\n" % current_item.get_value()
    
    if current_item.get_count() > 1:
        tooltip_text += "Count: %d" % current_item.get_count()
        if current_item.is_stackable():
            tooltip_text += "/%d" % current_item.get_max_stack_size()
    
    tooltip_label.text = tooltip_text

func _on_gui_input(event: InputEvent) -> void:
    if not current_item:
        return
    
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            item_selected.emit(current_item)
        elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            _show_context_menu()

func _show_context_menu() -> void:
    # Create a simple context menu
    var context_menu = PopupMenu.new()
    context_menu.add_item("Use Item")
    context_menu.add_item("Drop Item")
    context_menu.add_item("Examine")
    
    add_child(context_menu)
    context_menu.popup_centered()
    
    context_menu.id_pressed.connect(_on_context_menu_selected.bind(context_menu))

func _on_context_menu_selected(id: int, menu: PopupMenu) -> void:
    match id:
        0:  # Use Item
            item_used.emit(current_item)
        1:  # Drop Item
            item_dropped.emit(current_item)
        2:  # Examine
            item_selected.emit(current_item)
    
    menu.queue_free()

func is_empty() -> bool:
    return current_item == null
