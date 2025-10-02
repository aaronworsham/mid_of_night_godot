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
		await get_tree().create_timer(2).timeout
		print("CHALLENGE: success with roll %d vs target %d" % [c.dice_roll, c.skill_value])
		challenge_view.hide_challenge_ui()
		EventManager.event_test_challenge_succeeded.emit(c)
		EventManager.event_test_challenge_completed.emit(c)
	else:
		challenge_view.show_challenge_failure()
		await get_tree().create_timer(2).timeout
		print("CHALLENGE: failed with roll %d vs target %d" % [c.dice_roll, c.skill_value])
		challenge_view.hide_challenge_ui()
		EventManager.event_test_challenge_failed.emit(c)
		EventManager.event_test_challenge_completed.emit(c)


func show_digital_roll_ui() -> void:
	challenge_view.show_digital_roll_ui()
	await get_tree().create_timer(0.9).timeout
	submit_digital_roll()
