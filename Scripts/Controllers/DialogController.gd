class_name DialogController extends Node

@onready var thread_resource:Resource = ThreadResource.new()
@onready var thread_json:JSON = load ("res://Data/Threads/threads.strapi.json")
@onready var timeline_resource:TimelineResource = TimelineResource.new()
@onready var dialogic_timeline:DialogicTimeline
var current_threads:Dictionary


var timeline_keys:Array

func _ready() -> void:
	thread_resource.json = thread_json
	thread_resource.on_load()
	
	timeline_resource._threads_resource = thread_resource
	timeline_resource.on_load()

	EventManager.event_start_dialog.connect(_dialog_action)

func _dialog_action(_ac:ActorController): 
	print("DialogController: _dialog_action.  GUID:"+_ac.actor_resource.guid)
	current_threads  = timeline_resource.get_threads_for_actor_guid(_ac.actor_resource.guid)
	var timeline : DialogicTimeline = DialogicTimeline.new()
	timeline.events = current_threads["hello"]
	Dialogic.start(timeline)