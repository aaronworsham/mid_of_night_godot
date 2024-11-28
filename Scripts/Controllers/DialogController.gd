class_name DialogController extends Node

@onready var dialog_resource:DialogResource = load("res://Resources/Dialogs/Dialogs.tres")

var timeline_keys:Array

func _ready() -> void:
	dialog_resource.on_load()
	timeline_keys = dialog_resource.get_timelines()

func get_timeline_instructions(t:String) -> Array:
	if timeline_keys.has(t):
		return dialog_resource.get_instructions(t)
	return []