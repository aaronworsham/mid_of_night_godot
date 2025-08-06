class_name SkillResource extends Resource

var _skills_json:JSON = load("res://Data/Skills/skills.json")
var _skills_dict:Dictionary 

enum Skills {
    STRENGTH
} 

var skill_value:Dictionary

func on_load():
    _skills_dict = _skills_json.data.duplicate()
    for s in _skills_dict:
        skill_value[Skills[s]] = _skills_dict[s]

func reload():
    for s in _skills_dict:
        skill_value[Skills[s]] = _skills_dict[s]

func get_skill_value(s:Skills) -> int:
    return skill_value[s]

func set_skill_value(s:Skills, v:int) -> void:
    skill_value[s] = v

func increment_skill(s:Skills) -> void:
    skill_value[s] += 1

func decrement_skill(s:Skills) -> void:
    skill_value[s] -= 1
