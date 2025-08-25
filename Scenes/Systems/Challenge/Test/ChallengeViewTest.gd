class_name ChallengeViewTest extends Node
#@onready var challenge_view:ChallengeViewTest = %ChallengeViewTest
@onready var challenge_panel:Panel = %ChallengePanel

func _ready() -> void:
    challenge_panel.visible = false
    pass

func show_challenge_ui() -> void:
    challenge_panel.visible = true

func hide_challenge_ui() -> void:
    challenge_panel.visible = false
    #challenge_view.show_challenge_ui(challenge)