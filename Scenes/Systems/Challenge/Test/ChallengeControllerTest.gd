class_name ChallengeControllerTest extends Node
@onready var challenge_view:ChallengeViewTest = %ChallengeViewTest
#@onready var challenge_system_events: ChallengeSystemEventsTest = %ChallengeSystemEventsTest
#@onready var challenge_system_resource:ChallengeSystemResource = ChallengeSystemResource.new()

func _ready() -> void:
    pass

func submit_physical_roll(roll_value:int) -> void:
    print("CHALLENGE CONTROLLER: Physical Roll Submitted with value: " + str(roll_value))
    # Here you would typically handle the roll logic, e.g., check against a target number
    # For testing, we'll just emit a success or failure event based on a simple condition
    if roll_value >= 5:
        challenge_view.show_challenge_success()
    else:
        challenge_view.show_challenge_failure()