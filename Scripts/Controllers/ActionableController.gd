extends Node

@export var actionable:ActionableResource

func dialog_action()->void:
	Dialogic.start(actionable.timelineID)	
	return
