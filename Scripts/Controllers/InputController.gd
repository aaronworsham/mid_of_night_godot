extends Node

@onready var save_manager:SaveManager = %SaveManager

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_pressed("testing_ui"):
			EventManager.emit_testing_ui()
						
