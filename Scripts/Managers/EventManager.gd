extends Node

signal event_attributes_updated(attrs:Dictionary)
signal event_mysteries_updated(mystery:String)
signal event_start_dialog(act:ActionableController)


#Signals EM can emit for others to connect to
func emit_event_attributes_updated(attrs:Dictionary):
	event_attributes_updated.emit(attrs)

func emit_event_mysteries_updated(mystery:String):
	event_mysteries_updated.emit(mystery)

func emit_event_start_dialog(act:ActionableController):
	event_start_dialog.emit(act)


#Singals EM is connected to
func _on_dialogic_signal(argument:String):
	if argument == "uncover_missing_girl_mystery":
		print("Missing Girl Mystery Uncovered")
		emit_event_mysteries_updated("Missing Girl")