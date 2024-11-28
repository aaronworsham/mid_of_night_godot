class_name NotebookController
extends Node

var actor_controller:ActorController
var actor_resource:ActorResource
var notebook_resource:NotebookResource
var current_timeline_instructions:Array
var current_timeline:DialogicTimeline
@onready var notebook_view:NotebookView = get_node("/root/Main/UIOverlay/NotebookUI")

func _ready() -> void:
	EventManager.event_start_dialog.connect(_dialog_action)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _dialog_action(ac:ActorController): 
	print("NotebookController: _dialog_action")
	notebook_view.dialog_action(ac)

func _on_dialogic_signal(_argument:String):
	print("NotebookController: _on_dialogic_signal")
	notebook_view.on_dialogic_signal(_argument)
