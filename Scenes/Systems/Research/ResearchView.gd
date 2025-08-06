class_name ResearchView extends Node

@onready var casefile_items_vbox:VBoxContainer = %CasefileItemsVBox
@onready var content_display_lbox:RichTextLabel = %CasefileItemContentLBox

func _ready() -> void:
    EventManager.event_research_casefileui_add_research.connect(add_research_to_casefileui_item_vbox)


func add_research_to_casefileui_item_vbox(m:Dictionary) -> void:
    var btn = UIUtility.create_button(m["name"])
    btn.pressed.connect(self._button_pressed.bind(m))
    casefile_items_vbox.add_child(btn)

func _button_pressed(m:Dictionary)->void:
    var s:String
    for c in m["research_topics"]:
        s += c["name"]
        s += "\n"
    s += "END"
    content_display_lbox.text = s