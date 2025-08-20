class_name MysteryControllerTest extends Node

@onready var mystery_view: MysteryViewTest = %MysteryViewTest
@onready var mystery_panel: Panel = %MysteryPanel
@onready var mystery_system_events: MysteryEventsTest = %MysteryEventsTest

# Add mystery system resource similar to dialog system
@onready var mystery_system_resource: MysterySystemResource = MysterySystemResource.new()

var discovered_mysteries:Array[Dictionary] = []
var discovered_clues:Array[Dictionary] = []
var current_mystery: Dictionary
var current_clues: Array[Dictionary] = []
var actors: Array[ActorModel]

func _ready() -> void:
	mystery_panel.visible = false
	
	# Load mystery system resource
	mystery_system_resource.on_load()
	
	# Add event connections similar to DialogControllerTest
	EventManager.event_test_close_all_panels.connect(_on_event_close_all_panels)
	EventManager.event_test_mystery_tab_clicked.connect(_on_event_mystery_clicked)
	EventManager.event_test_mystery_discovered.connect(_on_mystery_discovered)
	EventManager.event_test_mystery_clue_discovered.connect(_on_clue_discovered)

func _on_event_actor_loaded(actor: ActorModel):
	actors.append(actor)

func _on_event_close_dialog() -> void:
	pass

func _on_event_mystery_clicked() -> void:
	mystery_panel.visible = true
	load_discovered_mysteries()

func _on_event_close_all_panels() -> void:
	mystery_panel.visible = false

func _on_mystery_discovered(mystery_guid: String):
	var mystery = mystery_system_resource.get_member_by_guid(mystery_guid)
	if mystery and not discovered_mysteries.has(mystery):
		discovered_mysteries.append(mystery)
		mystery_view.load_mystery_list(discovered_mysteries)

func _on_clue_discovered(clue_guid: String):
	var clue = mystery_system_resource.get_submember_by_guid(clue_guid)
	if clue and not discovered_clues.has(clue):
		discovered_clues.append(clue)
		mystery_system_resource.set_submember_as_discovered(clue_guid)

func set_current_mystery(mystery_guid: String):
	current_mystery = mystery_system_resource.get_member_by_guid(mystery_guid)
	current_clues = mystery_system_resource.get_submembers_from_member_guid(mystery_guid)

func load_discovered_mysteries():
	var discovered = mystery_system_resource.get_discovered_members()
	for mystery in discovered:
		if not discovered_mysteries.has(mystery):
			discovered_mysteries.append(mystery)
	mystery_view.load_mystery_list(discovered_mysteries)

func add_discovered_mystery(mystery:Dictionary) -> void:
	discovered_mysteries.append(mystery)
	mystery_view.load_mystery_list(discovered_mysteries)