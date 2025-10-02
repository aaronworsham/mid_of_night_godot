extends Node

@onready var skills_json:JSON = load("res://Data/Skills/skills.json")

var _character_resource:CharacterResource = CharacterResource.new()
var _character_skills:SkillsCollectionResource = SkillsCollectionResource.new()
var _dice_manager:DiceManager = DiceManager.new()

func _ready() -> void:
	_character_resource.on_load()
	_character_skills.json = skills_json
	_character_skills.on_load()

func get_character_name() -> String:
	return _character_resource.get_character_name()

func set_character_name(n:String) -> void:
	_character_resource.set_character_name(n)

func set_skill_value(skill_enum:String, v:int) ->void:
	var _skill_resource:SkillMemberResource = _character_skills.get_skill_by_enum(skill_enum)   
	_skill_resource.set_current_value(v)

func get_skill_value(skill_enum:String) -> int:
	var _skill_resource:SkillMemberResource = _character_skills.get_skill_by_enum(skill_enum)   
	return _skill_resource.get_current_value()



func get_random_cos(skill_enum:String)->ChanceOfSuccessResource:
	var _skill_resource:SkillMemberResource = _character_skills.get_skill_by_enum(skill_enum)   
	var c:ChanceOfSuccessResource = ChanceOfSuccessResource.new()
	var roll:int = _dice_manager.roll_d100()
	var skill_value:int = _skill_resource.get_skill_value()
	c.on_load(roll,_skill_resource,skill_value)
	return c

func get_set_cos(skill_enum:String, r:int)->ChanceOfSuccessResource:
	var _skill_resource:SkillMemberResource = _character_skills.get_skill_by_enum(skill_enum)   
	var c:ChanceOfSuccessResource = ChanceOfSuccessResource.new()
	var skill_value:int = _skill_resource.get_skill_value()
	c.on_load(r,_skill_resource,skill_value)
	return c
