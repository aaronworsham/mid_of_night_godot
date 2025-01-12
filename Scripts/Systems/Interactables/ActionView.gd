class_name ActionView extends Node2D

@onready var action_item_list:ItemList = %ActionItemList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_item_list.visible = false
	pass # Replace with function body.

func on_dialog_action():
	action_item_list.visible = true
