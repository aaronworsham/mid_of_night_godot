class_name SkillsCollectionResource extends Resource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _skills_array:Array

#dictionary of skills by enum
var _skills_dict_by_enum:Dictionary

func on_load():
    
    _skills_array.clear()

    #source of truth
    _skills_array = json.data.duplicate(true)

    for t in _skills_array:
        var skill_member:SkillMemberResource = SkillMemberResource.new()
        skill_member.setup(t)
        _skills_dict_by_enum[skill_member.get_enum()] = skill_member


func get_all_skills()->Array:
    return _skills_array

func get_skill_by_enum(e:String)->SkillMemberResource:
    return _skills_dict_by_enum[e]