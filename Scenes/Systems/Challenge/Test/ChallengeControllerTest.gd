class_name ChallengeControllerTest extends Node
@onready var challenge_view:ChallengeViewTest = %ChallengeViewTest
#@onready var challenge_system_events: ChallengeSystemEventsTest = %ChallengeSystemEventsTest
#@onready var challenge_system_resource:ChallengeSystemResource = ChallengeSystemResource.new()

func _ready() -> void:
    EventManager.event_test_challenge_given.connect(_on_event_challenge_given)
    EventManager.event_test_challenge_succeeded.connect(_on_event_challenge_succeeded)
    EventManager.event_test_challenge_failed.connect(_on_event_challenge_failed)

func _on_event_challenge_given(challenge:Dictionary) -> void:
    print("CHALLENGE: given challenge: " + challenge["name"])
    challenge_view.show_challenge_ui()

func _on_event_challenge_succeeded(challenge:Dictionary) -> void:
    print("CHALLENGE: succeeded challenge: " + challenge["name"])
    #challenge_view.show_challenge_success_ui(challenge)

func _on_event_challenge_failed(challenge:Dictionary) -> void:
    print("CHALLENGE: failed challenge: " + challenge["name"])
    #challenge_view.show_challenge_failure_ui(challenge)