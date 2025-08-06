extends Node

var _character_resource:CharacterResource = CharacterResource.new()
var _skill_resource:SkillResource = SkillResource.new()

func _ready() -> void:
    _character_resource.on_load()
    _skill_resource.on_load()

func get_character_name() -> String:
    return _character_resource.get_character_name()

func set_character_name(n:String) -> void:
    _character_resource.set_character_name(n)

func set_skill_value(s:SkillResource.Skills, v:int) ->void:
    _skill_resource.set_skill_value(s,v)

func get_skill_value(s:SkillResource.Skills) -> int:
    return _skill_resource.get_skill_value(s)

func increment_skill(s:SkillResource.Skills) -> void:
    _skill_resource.increment_skill(s)

func decrement_skill(s:SkillResource.Skills) -> void:
    _skill_resource.decrement_skill(s)

func reload_skills()-> void:
    _skill_resource.reload()