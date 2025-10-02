extends Node

# var _character_resource:CharacterResource = CharacterResource.new()
# var _skill_resource:SkillMemberResource = SkillMemberResource.new()
# var _dice_manager:DiceManager = DiceManager.new()

# func _ready() -> void:
#     _character_resource.on_load()
#     _skill_resource.on_load()

# func get_character_name() -> String:
#     return _character_resource.get_character_name()

# func set_character_name(n:String) -> void:
#     _character_resource.set_character_name(n)

# func set_skill_value(s:SkillMemberResource, v:int) ->void:
#     _skill_resource.set_current_value(v)

# func get_skill_value(s:SkillResource.Skills) -> int:
#     return _skill_resource.get_skill_value(s)

# func increment_skill(s:SkillResource.Skills) -> void:
#     _skill_resource.increment_skill(s)

# func decrement_skill(s:SkillResource.Skills) -> void:
#     _skill_resource.decrement_skill(s)

# func reload_skills()-> void:
#     _skill_resource.reload()

# func get_random_cos(s:SkillResource.Skills)->ChanceOfSuccessResource:
#     var c:ChanceOfSuccessResource = ChanceOfSuccessResource.new()
#     var roll:int = _dice_manager.roll_d100()
#     var skill_value:int = get_skill_value(s)
#     c.on_load(roll,s,skill_value)
#     return c

# func get_set_cos(s:SkillResource.Skills, r:int)->ChanceOfSuccessResource:
#     var c:ChanceOfSuccessResource = ChanceOfSuccessResource.new()
#     var skill_value:int = get_skill_value(s)
#     c.on_load(r,s,skill_value)
#     return c