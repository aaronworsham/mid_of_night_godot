class_name ResearchController extends Node

@onready var research_system_resource:ResearchSystemResource = ResearchSystemResource.new()

@onready var research_view:ResearchView = %ResearchView

func _ready() -> void:

    research_system_resource.on_load()

    EventManager.event_research_discovered.connect(research_discovered)
    EventManager.event_research_topic_discovered.connect(topic_discovered)
    EventManager.event_research_casefileui_populate_discovered_research.connect(populate_casefile_ui_with_discovered_research)

func research_discovered():
    print("Research Controller: Research Discovered")

func topic_discovered():
    print("research Controller: Topic Discovered")

func populate_casefile_ui_with_discovered_research():
    for m in research_system_resource.get_discovered_members():
        research_view.add_research_to_casefileui_item_vbox(m)
