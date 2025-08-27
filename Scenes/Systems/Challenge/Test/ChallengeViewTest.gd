class_name ChallengeViewTest extends Node
#@onready var challenge_view:ChallengeViewTest = %ChallengeViewTest
@onready var challenge_background_panel:Panel = %ChallengeBackgroundPanel
@onready var challenge_panel:Panel = %ChallengePanel
@onready var physical_roll_panel:Panel = %PhysicalRollPanel
@onready var digital_roll_panel:Panel = %DigitalRollPanel
@onready var challenge_result_panel:Panel = %ChallengeResultPanel
@onready var challenge_success_label:Label = %SuccessLbl
@onready var challenge_failure_label:Label = %FailureLbl

func _ready() -> void:
    EventManager.event_test_close_all_panels.connect(_on_event_close_all_panels)
    challenge_panel.visible = false
    physical_roll_panel.visible = false
    digital_roll_panel.visible = false
    challenge_background_panel.visible = false
    challenge_result_panel.visible = false
    pass

func show_challenge_ui() -> void:
    challenge_panel.visible = true
    challenge_background_panel.visible = true

func hide_challenge_ui() -> void:
    challenge_panel.visible = false
    challenge_background_panel.visible = false
    challenge_result_panel.visible = false
    physical_roll_panel.visible = false
    digital_roll_panel.visible = false
    #challenge_view.show_challenge_ui(challenge)

func _on_event_close_all_panels() -> void:
    hide_challenge_ui()
    hide_physical_roll_ui()
    hide_digital_roll_ui()

func show_physical_roll_ui() -> void:
    physical_roll_panel.visible = true

func hide_physical_roll_ui() -> void:
    physical_roll_panel.visible = false

func show_digital_roll_ui() -> void:
    digital_roll_panel.visible = true
    

func hide_digital_roll_ui() -> void:
    digital_roll_panel.visible = false

func show_challenge_results_ui() -> void:
    challenge_result_panel.visible = true

func hide_challenge_results_ui() -> void:
    challenge_result_panel.visible = false

func show_challenge_success() -> void:
    challenge_success_label.visible = true
    challenge_failure_label.visible = false
    show_challenge_results_ui()
    
func show_challenge_failure() -> void:
    challenge_success_label.visible = false
    challenge_failure_label.visible = true
    show_challenge_results_ui()
