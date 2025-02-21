
class_name SkillController extends Node

@onready var skill_resource:SkillResource = SkillResource.new()

func _ready() -> void:
    EventManager.event_skill_get_value.connect(get_skill_value)
    EventManager.event_skill_set_value.connect(set_skill_value)

func get_skill_value(s:SkillResource.Skills) -> int:
    return skill_resource.get_skill_value(s)

func set_skill_value(s:SkillResource.Skills, v:int)-> void:
    skill_resource.set_skill_value(s,v)