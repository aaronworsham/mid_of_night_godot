extends Node

signal event_attributes_updated(attrs:Dictionary)

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func emit_event_attributes_updated(attrs:Dictionary):
	event_attributes_updated.emit(attrs)

func _on_dialogic_signal(argument:String):
	if argument == "uncover_missing_girl_mystery":
		print("Missing Girl Mystery Uncovered")