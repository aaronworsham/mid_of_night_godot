class_name DetectiveManager
extends Node

var _dm = DetectiveModel.new()

func _ready() -> void:
	emit_attributes_update()


func get_strength() -> int:
	return _dm.get_att(DetectiveModel.AttributeNames.STRENGTH)

func save() -> Dictionary:
	return _dm.save()

func emit_attributes_update():
	EventManager.emit_event_attributes_updated(_dm.get_all_att())
