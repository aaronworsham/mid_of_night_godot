class_name DialogSystemEventsTest extends Node

signal event_close_dialog(_on_event_close_dialog: bool)

func _on_event_close_dialog() -> void:
	EventManager.event_test_dialog_closed.emit()
