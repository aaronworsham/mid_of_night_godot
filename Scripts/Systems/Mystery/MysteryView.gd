class_name MysteryView extends Node

@onready var casefile_items_vbox:VBoxContainer = %CaseFileItemsVBox
@onready var content_display_lbox:RichTextLabel = %ContentDisplayLBox

func _ready() -> void:
    EventManager.event_mystery_casefileui_add_mystery.connect(add_mystery_to_casefileui_item_vbox)


func add_mystery_to_casefileui_item_vbox(m:Dictionary) -> void:
    var btn = UIUtility.create_button(m["name"])
    btn.pressed.connect(self._button_pressed.bind(m))
    casefile_items_vbox.add_child(btn)

func _button_pressed(m:Dictionary)->void:
    var s:String
    for c in m["clues"]:
        s += c["name"]
        s += "\n"
    s += "END"
    content_display_lbox.text = s
