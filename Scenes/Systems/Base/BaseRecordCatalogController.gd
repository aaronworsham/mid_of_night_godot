extends Node

# BaseRecordCatalogController.gd
# Reusable base controller for catalog-style systems (e.g., Mystery, Clue, Research)
# Follows MVC pattern and event-driven architecture per project instructions.

class_name BaseRecordCatalogController

# Reference to the associated system resource (data)
var system_resource: BaseDataSystemResource = null
var discovered_records: Array[Dictionary] = []
var discovered_sub_records: Array[Dictionary] = []
var current_record: Dictionary = {}
var current_sub_record: Dictionary = {}
var actors: Array[ActorModel] = []

# Reference to the associated view (UI)
var view: Node = null

func _ready():
    # Connect to relevant EventManager signals here if needed
    # Example: EventManager.event_interactable_actor_clicked.connect(_on_actor_clicked)
    pass

func initialize(r: BaseDataSystemResource, v: Node) -> void:
    system_resource = r
    view = v
    system_resource.on_load()


func discover_record(record_guid: String) -> void:
    if system_resource:
        system_resource.set_member_as_discovered(record_guid)

func discover_sub_record(submember_guid: String) -> void:
    if system_resource:
        system_resource.set_submember_as_discovered(submember_guid)


func load_discovered_records() -> void:
    if system_resource:
        discovered_records = system_resource.get_discovered_members()
        view.load_record_list(discovered_records)

func load_discovered_sub_records(record_guid: String) -> void:
    if system_resource:
        discovered_sub_records = system_resource.get_discovered_submembers_by_member_guid(record_guid)
        view.load_subrecord_list(discovered_sub_records)

func show_panel() -> void:
    if view and view.has_method("show_panel"):
        view.show_panel()

