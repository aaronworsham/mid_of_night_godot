class_name DialogController extends Node

@onready var dialog_view:DialogView = %DialogView
# @onready var threads_resource: Resource = ThreadCollectionResource.new()
# @onready var thread_json: JSON = load("res://Data/Threads/threads.strapi.json")
# @onready var timeline_resource: TimelineResource = TimelineResource.new()
# @onready var dialogic_timeline: DialogicTimeline


@onready var dialog_system_resource:DialogSystemResource = DialogSystemResource.new()


var current_dialog: Dictionary
var current_dialog_threads: Array
var current_thread: Dictionary

func _ready() -> void:

    dialog_system_resource.on_load()

    # timeline_resource._threads_resource = threads_resource
    # timeline_resource.on_load()

    EventManager.event_interactable_actor_clicked.connect(_interactable_actor_clicked)
    # EventManager.event_start_dialog.connect(_dialog_action)
    # EventManager.event_notebook_clicked.connect(_notebook_clicked_action)

func _interactable_actor_clicked(actor:ActorModel):
    
    current_dialog = dialog_system_resource.get_member_by_guid(actor.get_dialog_guid())
    current_dialog_threads = dialog_system_resource.get_submembers_from_member_guid(current_dialog["guid"])
    dialog_view.show_dialog_ui()
    show_discovered_threads()
    

        

# func _notebook_clicked_action(topic: Dictionary):
#     execute_thread_instructions(current_threads[topic["category_key"]])

# func _dialog_action(_ac: ActorController):
#     current_threads = timeline_resource.get_threads_for_actor_guid(_ac.actor_resource.guid)
#     dialog_view.show_dialog_ui()
#     execute_thread_instructions(current_threads["hello"])

func set_current_thread(guid):
    current_thread = dialog_system_resource.get_submember_by_guid(guid)
    execute_thread_instructions()

func show_discovered_threads():
    for t in current_dialog_threads:
        if t["starts_discovered"]:
            dialog_view.add_topic(t)  #TODO only add if it is a new topic

    var discovered:Array = dialog_system_resource.get_discorvered_submembers()
    for r in discovered:
        dialog_view.add_topic(r)

    dialog_view.load_topic_list()

func execute_thread_instructions():
    for i in current_thread["instructions"]:
        match i["__component"]:
            "thread-instruction.thread-statement":
                dialog_view.update_dialog(i["copy"])
            "thread-instruction.thread-discovered":
                dialog_view.update_dialog(i["copy"])
                dialog_system_resource.set_submember_as_discovered(i["thread"]["guid"])
                dialog_view.clear_topics()
                dialog_view.clear_topic_list()
                show_discovered_threads()
            "thread-instruction.clue-discovered":
                EventManager.event_mystery_clue_discovered.emit(i["clue"]["guid"])
            "thread-instruction.mystery-discovered":
                EventManager.event_mystery_discovered.emit(i["mystery"]["guid"])
            "thread-instruction.topic-discovered":
                EventManager.event_research_discovered.emit(i["research_topic"]["guid"])

    


func _on_dialog_close_btn_pressed() -> void:
    dialog_view.hide_dialog_ui()
    EventManager.event_dialog_closed.emit()
