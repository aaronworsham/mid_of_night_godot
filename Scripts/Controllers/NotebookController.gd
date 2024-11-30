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
	EventManager.event_notebook_new_topic.connect(_on_new_topic_event)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _dialog_action(_ac:ActorController): 
	notebook_view.show_notebook()

func _on_dialogic_signal(_argument:String):
	print("NotebookController: _on_dialogic_signal")
	notebook_view.on_dialogic_signal(_argument)

func _on_new_topic_event(topic:Dictionary):
	notebook_view.add_topic(topic)
	
