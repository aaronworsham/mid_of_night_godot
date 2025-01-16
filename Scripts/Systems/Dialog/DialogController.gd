class_name DialogController extends Node

@onready var dialog_view:DialogView = get_node("/root/Main/UIOverlay/DialogUI")
@onready var thread_resource: Resource = ThreadResource.new()
@onready var thread_json: JSON = load("res://Data/Threads/threads.strapi.json")
@onready var timeline_resource: TimelineResource = TimelineResource.new()
@onready var dialogic_timeline: DialogicTimeline
var current_threads: Dictionary


var timeline_keys: Array

func _ready() -> void:
    thread_resource.json = thread_json
    thread_resource.on_load()
    
    timeline_resource._threads_resource = thread_resource
    timeline_resource.on_load()

    EventManager.event_start_dialog.connect(_dialog_action)
    EventManager.event_notebook_clicked.connect(_notebook_clicked_action)
    EventManager.event_interactable_actor_clicked.connect(_interactable_actor_clicked)

func _interactable_actor_clicked(actor:ActorModel):
    print("Interactable Event.  Actor Clicked:" + actor.get_actor_name())

func _notebook_clicked_action(topic: Dictionary):
    execute_thread_instructions(current_threads[topic["category_key"]])

func _dialog_action(_ac: ActorController):
    current_threads = timeline_resource.get_threads_for_actor_guid(_ac.actor_resource.guid)
    dialog_view.show_dialog_ui()
    execute_thread_instructions(current_threads["hello"])

func execute_thread_instructions(instructions:Array):
    for i in instructions:
        match i["__component"]:
            "timeline.thread.start":
                pass
            "timeline.timeline-dialog":
                dialog_view.update_dialog(i["text"])
            "timeline.timeline-signal":
                EventManager.event_notebook_new_topic.emit(i)
            "timeline.casefile-signal":
                EventManager.event_casefile_updated.emit(i)
            "timeline.thread-voiceover":
                pass
            "timeline.thread-end":
                pass
    
