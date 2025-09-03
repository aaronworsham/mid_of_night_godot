class_name NewCharController extends Node

@onready var new_char_view:NewCharView = %NewCharView

func _ready() -> void:
    EventManager.event_test_new_character_button.connect(_on_event_test_new_character_button)
    pass

func _on_event_test_new_character_button() -> void:
    new_char_view.show_new_char_panel()