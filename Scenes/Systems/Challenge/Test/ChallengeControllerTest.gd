class_name ChallengeControllerTest extends Node
@onready var challenge_view:ChallengeViewTest = %ChallengeViewTest
@onready var chance:ChanceOfSuccessResource = preload("res://Scenes/Systems/Randomization/ChanceOfSuccessResource.gd").new()
@onready var dice:DiceManager = DiceManager.new()

func _ready() -> void:
    chance.skill_value = 10
    chance.skill = SkillResource.Skills.STRENGTH
    pass

func submit_physical_roll(roll_value:int) -> void:
    print("CHALLENGE CONTROLLER: Physical Roll Submitted with value: " + str(roll_value))
    # Here you would typically handle the roll logic, e.g., check against a target number
    # For testing, we'll just emit a success or failure event based on a simple condition
    chance.dice_roll = roll_value
    if chance.is_success():
        challenge_view.show_challenge_success()
    else:
        challenge_view.show_challenge_failure()