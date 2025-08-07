class_name InventoryController extends Node

signal item_added(item: ItemResource)
signal item_removed(item: ItemResource)
signal item_used(item: ItemResource)
signal inventory_changed()
signal weight_changed(current_weight: float, max_weight: float)

@onready var inventory_view: InventoryView = %InventoryView

var _items_resource: ItemsResource
@export var _inventory: Array[ItemResource] = []
@export var max_weight: float = 100.0
@export var max_slots: int = 50

var _current_weight: float = 0.0

func _ready() -> void:
    on_load()

func on_load() -> void:
    _items_resource = ItemsResource.new()
    _items_resource.on_load()
    _inventory.clear()
    _current_weight = 0.0

func add_to_inventory(item: ItemResource) -> bool:
    if not can_add_item(item):
        return false
    
    # Try to stack with existing items first
    for existing_item in _inventory:
        if existing_item.can_stack_with(item):
            var space_in_stack = existing_item.get_max_stack_size() - existing_item.get_count()
            if space_in_stack > 0:
                var amount_to_add = min(item.get_count(), space_in_stack)
                existing_item.set_count(existing_item.get_count() + amount_to_add)
                item.set_count(item.get_count() - amount_to_add)
                _update_weight()
                inventory_changed.emit()
                
                if item.get_count() <= 0:
                    item_added.emit(existing_item)
                    return true
    
    # If item still has count and we have space, add as new stack
    if item.get_count() > 0 and _inventory.size() < max_slots:
        _inventory.append(item)
        _update_weight()
        inventory_changed.emit()
        item_added.emit(item)
        return true
    
    return false

func remove_from_inventory(item: ItemResource, amount: int = 1) -> bool:
    var index = _inventory.find(item)
    if index == -1:
        return false
    
    var current_count = item.get_count()
    if current_count <= amount:
        # Remove entire stack
        _inventory.remove_at(index)
        _update_weight()
        inventory_changed.emit()
        item_removed.emit(item)
        return true
    else:
        # Reduce stack size
        item.set_count(current_count - amount)
        _update_weight()
        inventory_changed.emit()
        return true

func use_item(item: ItemResource) -> bool:
    if has_item(item):
        remove_from_inventory(item, 1)
        item_used.emit(item)
        return true
    return false

func has_item(item: ItemResource) -> bool:
    return _inventory.has(item)

func has_item_by_guid(guid: String) -> bool:
    for item in _inventory:
        if item.get_guid() == guid:
            return true
    return false

func get_item_by_guid(guid: String) -> ItemResource:
    for item in _inventory:
        if item.get_guid() == guid:
            return item
    return null

func get_inventory() -> Array[ItemResource]:
    return _inventory

func get_items() -> Array:
    return _items_resource.get_items_as_resources()

func get_total_weight() -> float:
    return _current_weight

func get_max_weight() -> float:
    return max_weight

func get_weight_percentage() -> float:
    return (_current_weight / max_weight) * 100.0

func get_slots_used() -> int:
    return _inventory.size()

func get_slots_available() -> int:
    return max_slots - _inventory.size()

func can_add_item(item: ItemResource) -> bool:
    # Check weight limit
    if _current_weight + item.get_total_weight() > max_weight:
        return false
    
    # Check if we can stack with existing items
    for existing_item in _inventory:
        if existing_item.can_stack_with(item):
            return true
    
    # Check slot limit
    return _inventory.size() < max_slots

func _update_weight() -> void:
    var new_weight = 0.0
    for item in _inventory:
        new_weight += item.get_total_weight()
    
    if new_weight != _current_weight:
        _current_weight = new_weight
        weight_changed.emit(_current_weight, max_weight)

func clear_inventory() -> void:
    _inventory.clear()
    _current_weight = 0.0
    inventory_changed.emit()
    weight_changed.emit(_current_weight, max_weight)

func save_inventory() -> Dictionary:
    var save_data = {
        "max_weight": max_weight,
        "max_slots": max_slots,
        "current_weight": _current_weight,
        "items": []
    }
    
    for item in _inventory:
        save_data["items"].append(item.to_dict())
    
    return save_data

func load_inventory(save_data: Dictionary) -> void:
    max_weight = save_data.get("max_weight", 100.0)
    max_slots = save_data.get("max_slots", 50)
    _current_weight = save_data.get("current_weight", 0.0)
    
    _inventory.clear()
    for item_data in save_data.get("items", []):
        var item = ItemResource.new()
        item.from_dict(item_data)
        _inventory.append(item)
    
    inventory_changed.emit()
    weight_changed.emit(_current_weight, max_weight)

func _on_inventory_btn_pressed() -> void:
    inventory_view.refresh_display()

func get_items_by_type(item_type: String) -> Array[ItemResource]:
    var filtered_items: Array[ItemResource] = []
    for item in _inventory:
        if item.get_item_type() == item_type:
            filtered_items.append(item)
    return filtered_items

func get_items_by_rarity(rarity: String) -> Array[ItemResource]:
    var filtered_items: Array[ItemResource] = []
    for item in _inventory:
        if item.get_rarity() == rarity:
            filtered_items.append(item)
    return filtered_items

func sort_inventory_by_name() -> void:
    _inventory.sort_custom(func(a, b): return a.get_item_name() < b.get_item_name())
    inventory_changed.emit()

func sort_inventory_by_value() -> void:
    _inventory.sort_custom(func(a, b): return a.get_total_value() > b.get_total_value())
    inventory_changed.emit()

func sort_inventory_by_weight() -> void:
    _inventory.sort_custom(func(a, b): return a.get_total_weight() < b.get_total_weight())
    inventory_changed.emit()
