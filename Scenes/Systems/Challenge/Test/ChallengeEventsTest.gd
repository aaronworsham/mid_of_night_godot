class_name ChallengeEventsTest extends Node
@onready var view:ChallengeViewTest = %ChallengeViewTest
@onready var controller:ChallengeControllerTest = %ChallengeControllerTest
@onready var roll_digital_btn:Button = %RollDigitalBtn
@onready var roll_physical_btn:Button = %RollPhysicalBtn
@onready var physical_roll_submit_btn:Button = %PhysicalRollSubmitBtn
@onready var physical_roll_input:LineEdit = %PhysicalRollInput

func _ready() -> void:
    roll_digital_btn.pressed.connect(_on_roll_digital_pressed)
    roll_physical_btn.pressed.connect(_on_roll_physical_pressed)
    physical_roll_submit_btn.pressed.connect(_on_physical_roll_submit_pressed)
    EventManager.event_test_challenge_given.connect(_on_event_challenge_given)
    EventManager.event_test_challenge_succeeded.connect(_on_event_challenge_succeeded)
    EventManager.event_test_challenge_failed.connect(_on_event_challenge_failed)
    EventManager.event_test_close_all_panels.connect(_on_event_close_all_panels)
    pass

func _on_event_challenge_given(challenge:Dictionary) -> void:
    view.show_challenge_ui()

func _on_event_challenge_succeeded(challenge:Dictionary) -> void:
    pass

func _on_event_challenge_failed(challenge:Dictionary) -> void:
    pass

func _on_roll_digital_pressed() -> void:
    view.show_digital_roll_ui()
    await get_tree().create_timer(0.9).timeout
    controller.submit_digital_roll()


func _on_roll_physical_pressed() -> void:
    view.show_physical_roll_ui()

func _on_event_close_all_panels() -> void:
    view.hide_challenge_ui()

func _on_physical_roll_submit_pressed() -> void:
    controller.submit_physical_roll(physical_roll_input.text.to_int())