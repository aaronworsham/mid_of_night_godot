class_name InventoryController extends Node


@export var _inventory:Array

func _ready() -> void:
    _inventory.clear()

func on_load() -> void:
    _inventory.clear()

func add_to_inventory(i:ItemResource) -> void:
    _inventory.append(i)

func get_inventory() -> Array:
    return _inventory


func _on_inventory_btn_pressed() -> void:
    pass # Replace with function body.
