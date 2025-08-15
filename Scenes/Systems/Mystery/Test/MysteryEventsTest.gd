class_name MysteryEventsTest extends Node

@onready var mystery_close_btn: Button = %MysteryCloseBtn


func _ready() -> void:
    mystery_close_btn.pressed.connect(_on_mystery_close_btn_pressed)

func _on_mystery_close_btn_pressed() -> void:
    EventManager.event_test_close_all_panels.emit()
    EventManager.event_test_show_all_actors.emit()