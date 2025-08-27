class_name DialogControllerTest extends Node

@onready var dialog_view:DialogViewTest = %DialogViewTest
@onready var dialog_system_events: DialogEventsTest = %DialogEventsTest
# @onready var threads_resource: Resource = ThreadCollectionResource.new()
# @onready var thread_json: JSON = load("res://Data/Threads/threads.strapi.json")
# @onready var timeline_resource: TimelineResource = TimelineResource.new()
# @onready var dialogic_timeline: DialogicTimeline


@onready var dialog_system_resource:DialogSystemResource = DialogSystemResource.new()

var actors:Array[ActorModel]
var current_dialog: Dictionary
var current_dialog_threads: Array
var current_thread: Dictionary

func _ready() -> void:

	dialog_system_resource.on_load()


	EventManager.event_test_interactable_actor_clicked.connect(_interactable_actor_clicked)
	EventManager.event_test_dialog_tab_clicked.connect(_on_event_dialog_clicked)	

	EventManager.event_actor_loaded.connect(_on_event_actor_loaded)


func _on_event_actor_loaded(actor:ActorModel):
	actors.append(actor)

func _interactable_actor_clicked(actor:ActorModel):
	print("DIALOG: got actor: " + actor.get_actor_name())

	show_dialog_ui(actor)

	current_dialog = dialog_system_resource.get_member_by_guid(actor.get_dialog_guid())
	current_dialog_threads = dialog_system_resource.get_submembers_from_member_guid(current_dialog["guid"])
	dialog_view.show_dialog_ui(actor)
	show_discovered_threads()

func _on_event_dialog_clicked():
	dialog_view.show_dialog_ui_no_actor(actors[0])

func show_dialog_ui(actor:ActorModel):
	dialog_view.show_dialog_ui(actor)

func set_current_thread(guid):
	current_thread = dialog_system_resource.get_submember_by_guid(guid)
	execute_thread_instructions()

func show_discovered_threads():
	for t in current_dialog_threads:
		if t["starts_discovered"]:
			dialog_view.add_topic(t)  #TODO only add if it is a new topic

	var discovered:Array = dialog_system_resource.get_discovered_submembers_by_member_guid(current_dialog["guid"])
	for r in discovered:
		dialog_view.add_topic(r)


	dialog_view.load_topic_list()

func execute_thread_instructions():
	for i in current_thread["instructions"]:
		match i["__component"]:
			"thread-instruction.thread-challenged":
				print("DIALOG: challenged thread: " + current_thread["guid"])
				EventManager.event_test_challenge_given.emit(i)
				var c:ChanceOfSuccessResource = await EventManager.event_test_challenge_completed
				if c.is_success():
					print("DIALOG: challenge succeeded")
					continue
				else:
					print("DIALOG: challenge failed")
					break	
			"thread-instruction.thread-statement":
				dialog_view.update_dialog(i["copy"])
			"thread-instruction.thread-discovered":
				dialog_view.update_dialog(i["copy"])
				dialog_system_resource.set_submember_as_discovered(i["thread"]["guid"])
				dialog_view.clear_topics()
				dialog_view.clear_topic_list()
				show_discovered_threads()
			"thread-instruction.clue-discovered":
				print("DIALOG: discovered clue: " + i["clue"]["guid"])
				EventManager.event_test_mystery_clue_discovered.emit(i["clue"]["guid"])
			"thread-instruction.mystery-discovered":
				print("DIALOG: discovered mystery: " + i["mystery"]["guid"])
				EventManager.event_test_mystery_discovered.emit(i["mystery"]["guid"])
			"thread-instruction.topic-discovered":
				EventManager.event_research_discovered.emit(i["research_topic"]["guid"])

	


