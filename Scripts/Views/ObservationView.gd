class_name ObservationView extends Node2D

@onready var observation_item_list:ItemList = %ObservationItemList
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	observation_item_list.visible = false
	pass # Replace with function body.

func on_start_dialog():
	observation_item_list.visible = true
