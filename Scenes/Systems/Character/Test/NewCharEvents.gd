class_name NewCharEvents extends Node

@onready var back_to_options_btn:Button = %BackToOptionsBtn
@onready var new_char_controller:NewCharController = %NewCharController
@onready var new_char_view:NewCharView = %NewCharView


func _ready() -> void:
    back_to_options_btn.pressed.connect(_on_back_to_options_btn_pressed)
    pass

func _on_back_to_options_btn_pressed() -> void:
    new_char_view.hide_new_char_panel()
    EventManager.event_test_back_to_options_button.emit()
    print("Back to Options Button Pressed")