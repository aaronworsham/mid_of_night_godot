extends Node

signal event_attributes_updated(attrs:Dictionary)

signal event_mysteries_updated(mystery:String)

signal event_start_dialog(act:ActorController)
signal event_notebook_new_topic(topic:Dictionary)
signal event_casefile_updated(data:Dictionary)

signal event_notebook_clicked(topic)
signal event_testing_ui()
signal event_save_game()
signal event_load_game()


#Signals EM can emit for others to connect to
func emit_event_attributes_updated(attrs:Dictionary):
	event_attributes_updated.emit(attrs)

func emit_event_mysteries_updated(mystery:String):
	event_mysteries_updated.emit(mystery)

func emit_event_start_dialog(act:ActorController):
	event_start_dialog.emit(act)

func emit_event_notebook_clicked(topic:Dictionary):
	event_notebook_clicked.emit(topic)

func emit_testing_ui():
	event_testing_ui.emit()

func emit_save_game():
	event_save_game.emit()

func emit_load_game():
	event_load_game.emit()

#Singals EM is connected to
func _on_dialogic_signal(argument:String):
	if argument == "uncover_missing_girl_mystery":
		print("Missing Girl Mystery Uncovered")
		emit_event_mysteries_updated("Missing Girl")