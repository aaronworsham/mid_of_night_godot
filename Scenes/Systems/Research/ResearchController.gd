class_name ResearchController extends Node

@onready var research_system_resource:ResearchSystemResource = ResearchSystemResource.new()

@onready var research_view:ResearchView = %ResearchView

func _ready() -> void:

    research_system_resource.on_load()

    EventManager.event_research_discovered.connect(research_discovered)
    EventManager.event_research_topic_discovered.connect(topic_discovered)

func research_discovered(guid:String):
    research_system_resource.set_member_as_discovered(guid)

func topic_discovered(guid):
    research_system_resource.set_submember_as_discovered(guid)

func _on_research_btn_pressed() -> void:
    for m in research_system_resource.get_members():
        research_view.add_research_to_casefileui_item_vbox(m)
