class_name InventoryController extends Node

var _items_resource:ItemsResource
@export var _inventory:Array

func _ready() -> void:
    on_load()

func on_load() -> void:
    _items_resource = ItemsResource.new()
    _items_resource.on_load()
    _inventory.clear()

func add_to_inventory(i:ItemResource) -> void:
    _inventory.append(i)

func get_inventory() -> Array:
    return _inventory

func get_items()-> Array:
    return _items_resource.get_items_as_resources()

func _on_inventory_btn_pressed() -> void:
    pass # Replace with function body.
