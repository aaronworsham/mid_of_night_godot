class_name MysteryController extends Node

@onready var mysteries_resource:MysteryCollectionResource = MysteryCollectionResource.new()
@onready var mysteries_json:JSON = load ("res://Data/StrapiData/Collections/mysteries.collection.strapi.json")

@onready var clues_resource:ClueCollectionResource = ClueCollectionResource.new()
@onready var clues_json:JSON = load ("res://Data/StrapiData/Collections/clues.collection.strapi.json")

@onready var mystery_view:Control = get_node("../CaseFileUI/")

func _ready() -> void:
    mysteries_resource.json = mysteries_json
    mysteries_resource.on_load()
    EventManager.event_mystery_discovered.connect(mystery_discovered)
    EventManager.event_mystery_clue_discovered.connect(clue_discovered)
    EventManager.event_mystery_casefileui_populate_discovered_mysteries.connect(populate_casefile_ui_with_discovered_mysteries)

func mystery_discovered():
    print("Mystery Controller: Mystery Discovered")

func clue_discovered():
    print("Mystery Controller: Clue Discovered")

func populate_casefile_ui_with_discovered_mysteries():
    for m in mysteries_resource.get_all_discovered_mysteries():
        EventManager.event_mystery_casefileui_add_mystery.emit(m)
