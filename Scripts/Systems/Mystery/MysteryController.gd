class_name MysteryController extends Node



@onready var mystery_system_resource:MysterySystemResource = MysterySystemResource.new()

@onready var mystery_view:MysteryView = %MysteryView

func _ready() -> void:

    mystery_system_resource.on_load()

    EventManager.event_mystery_discovered.connect(mystery_discovered)
    EventManager.event_mystery_clue_discovered.connect(clue_discovered)

func mystery_discovered(guid:String):
    mystery_system_resource.set_member_as_discovered(guid)

func clue_discovered(guid:String):
    mystery_system_resource.set_submember_as_discovered(guid)


func _on_mystery_btn_pressed() -> void:
    for m in mystery_system_resource.get_discovered_members():
        mystery_view.add_mystery_to_casefileui_item_vbox(m)
