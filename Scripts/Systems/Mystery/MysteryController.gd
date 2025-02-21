class_name MysteryController extends Node



@onready var mystery_system_resource:MysterySystemResource = MysterySystemResource.new()

@onready var mystery_view:MysteryView = %MysteryView

func _ready() -> void:

    mystery_system_resource.on_load()

    EventManager.event_mystery_discovered.connect(mystery_discovered)
    EventManager.event_mystery_clue_discovered.connect(clue_discovered)
    EventManager.event_mystery_casefileui_populate_discovered_mysteries.connect(populate_casefile_ui_with_discovered_mysteries)

func mystery_discovered():
    print("Mystery Controller: Mystery Discovered")

func clue_discovered():
    print("Mystery Controller: Clue Discovered")

func populate_casefile_ui_with_discovered_mysteries():
    for m in mystery_system_resource.get_discovered_members():
        mystery_view.add_mystery_to_casefileui_item_vbox(m)
