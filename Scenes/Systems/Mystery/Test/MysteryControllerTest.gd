class_name MysteryControllerTest extends BaseRecordCatalogController

@onready var mystery_view: MysteryViewTest = %MysteryViewTest
@onready var mystery_panel: Panel = %MysteryPanel
@onready var mystery_system_events: MysteryEventsTest = %MysteryEventsTest

# Add mystery system resource similar to dialog system
@onready var mystery_system_resource: MysterySystemResource = MysterySystemResource.new()



func _ready() -> void:
	mystery_panel.visible = false
	
	# Load mystery system resource
	super.initialize(mystery_system_resource, mystery_view)
	
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
	super.discover_record(mystery_guid)

func _on_clue_discovered(clue_guid: String):
	super.discover_sub_record(clue_guid)

func load_discovered_mysteries():
	super.load_discovered_records()
