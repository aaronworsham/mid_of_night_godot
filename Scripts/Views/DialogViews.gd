class_name DialogView extends Node

@onready var dialog_list: ItemList = %DialogItemList

func _ready() -> void:
    dialog_list.clear()
    dialog_list.visible = false

func update_dialog():
    dialog_list.visible = true
    dialog_list.add_item("Test")
