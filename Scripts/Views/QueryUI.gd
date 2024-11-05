class_name QueryUI
extends Node


func _ready() -> void:
	EventManager.event_attributes_updated.connect(_recieve_attributes_update)

func _recieve_attributes_update(atts:Dictionary):
	var strength = atts[DetectiveModel.AttributeNames.STRENGTH]
	print("got Signal")
	print(strength)



func _on_query_edit_focus_entered() -> void:
	print("Focus Entered")
	pass # Replace with function body.


func _on_query_edit_focus_exited() -> void:
	print("Focus Exited")
	pass # Replace with function body.


func _on_query_edit_mouse_entered() -> void:
	print("Mouse Entered")
	pass # Replace with function body.


func _on_query_edit_mouse_exited() -> void:
	print("Mouse Exited")
	pass # Replace with function body.
