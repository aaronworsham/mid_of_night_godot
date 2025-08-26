class_name ChallengeControllerTest extends Node
@onready var challenge_view:ChallengeViewTest = %ChallengeViewTest
@onready var chance:ChanceOfSuccessResource = preload("res://Scenes/Systems/Randomization/ChanceOfSuccessResource.gd").new()
@onready var dice:DiceManager = DiceManager.new()

func _ready() -> void:
    pass

func submit_physical_roll(roll_value:int) -> void:
    var skill = SkillResource.Skills.STRENGTH
    CharacterManager.set_skill_value(skill, 10)
    var c = CharacterManager.get_set_cos(skill, roll_value) 
    if c.is_success():
        challenge_view.show_challenge_success()
    else:
        challenge_view.show_challenge_failure()

func submit_digital_roll() -> void:
    var skill = SkillResource.Skills.STRENGTH
    CharacterManager.set_skill_value(skill, 50)
    var c = CharacterManager.get_random_cos(skill) 
    print("DICE ROLL: %d" % c.dice_roll)
    if c.is_success():
        challenge_view.show_challenge_success()
    else:
        challenge_view.show_challenge_failure()