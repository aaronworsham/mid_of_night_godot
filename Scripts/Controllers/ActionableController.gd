extends Node

@export var actionable: ActionableResource

func dialog_action() -> void:
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return
	else:
		Dialogic.start('test_timeline')
	
	return
