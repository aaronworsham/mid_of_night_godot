class_name DialogController extends Node

@onready var dialog_view:DialogView = %DialogView
# @onready var threads_resource: Resource = ThreadCollectionResource.new()
# @onready var thread_json: JSON = load("res://Data/Threads/threads.strapi.json")
# @onready var timeline_resource: TimelineResource = TimelineResource.new()
# @onready var dialogic_timeline: DialogicTimeline

@onready var dialogs_resource:DialogCollectionResource = DialogCollectionResource.new()
@onready var dialogs_json:JSON = load ("res://Data/StrapiData/Collections/dialogs.collection.strapi.json")

@onready var threads_resource: = ThreadCollectionResource.new()
@onready var threads_json:JSON = load ("res://Data/StrapiData/Collections/threads.collection.strapi.json")



var current_dialog: Dictionary
var current_dialog_threads: Array
var current_thread: Dictionary

func _ready() -> void:

    dialogs_resource.json = dialogs_json
    dialogs_resource.on_load()

    threads_resource.json = threads_json
    threads_resource.on_load()
    
    # timeline_resource._threads_resource = threads_resource
    # timeline_resource.on_load()

    EventManager.event_interactable_actor_clicked.connect(_interactable_actor_clicked)
    # EventManager.event_start_dialog.connect(_dialog_action)
    # EventManager.event_notebook_clicked.connect(_notebook_clicked_action)

func _interactable_actor_clicked(actor:ActorModel):
    current_dialog = dialogs_resource.get_dialog_by_guid(actor.get_dialog_guid())
    current_dialog_threads = threads_resource.get_threads_by_dialog_guid(current_dialog["guid"])
    dialog_view.show_dialog_ui()
    show_discovered_threads()
    

        

# func _notebook_clicked_action(topic: Dictionary):
#     execute_thread_instructions(current_threads[topic["category_key"]])

# func _dialog_action(_ac: ActorController):
#     current_threads = timeline_resource.get_threads_for_actor_guid(_ac.actor_resource.guid)
#     dialog_view.show_dialog_ui()
#     execute_thread_instructions(current_threads["hello"])

func set_current_thread(guid):
    current_thread = threads_resource.get_thread_by_guid(guid)
    execute_thread_instructions()

func show_discovered_threads():
    for t in current_dialog_threads:
        if t["starts_discovered"]:
            dialog_view.add_topic(t)

    var discovered:Array = threads_resource.get_discovered_threads()
    for r in discovered:
        dialog_view.add_topic(r)

    dialog_view.load_notebook_list()

func execute_thread_instructions():
    for i in current_thread["instructions"]:
        match i["__component"]:
            "thread-instruction.thread-statement":
                dialog_view.update_dialog(i["copy"])
            "thread-instruction.thread-discovered":
                dialog_view.update_dialog(i["copy"])
                threads_resource.set_thread_as_discovered(i["thread"]["guid"])
                dialog_view.clear_topics()
                show_discovered_threads()
            "thread-instruction.clue-discovered":
                EventManager.event_mystery_clue_discovered.emit()
            "thread-instruction.mystery-discovered":
                EventManager.event_mystery_discovered.emit()
            "thread-instruction.topic-discovered":
                print("Research Topic Discovered")

    
