class_name DialogEventsTest extends Node

@onready var dialog_close_btn: Button = %DialogCloseBtn
@onready var dialog_view:DialogViewTest = %DialogViewTest
@onready var dialog_controller:DialogControllerTest = %DialogControllerTest

func _ready() -> void:
	dialog_close_btn.pressed.connect(_on_dialog_close_btn_pressed)
	pass

func _on_dialog_close_btn_pressed() -> void:
	EventManager.event_test_close_all_panels.emit()
	EventManager.event_test_show_all_actors.emit()
	dialog_view.hide_dialog_ui()
