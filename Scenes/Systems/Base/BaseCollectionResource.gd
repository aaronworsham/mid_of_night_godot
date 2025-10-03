class_name BaseCollectionResource extends BaseResource

@export var json:JSON:
	set(value):
		json = value

#source of truth (direct from json)
var _members_array:Array

#dictionary of skills by enum
var _skills_dict_by_enum:Dictionary

func on_load():
	
	_members_array.clear()

	#source of truth
	_members_array = json.data.duplicate(true)

	for t in _members_array:
		var skill_member:SkillMemberResource = SkillMemberResource.new()
		skill_member.setup(t)
		_skills_dict_by_enum[skill_member.get_enum()] = skill_member


func get_all_members()->Array:
	return _members_array

func get_member_by_enum(e:String)->SkillMemberResource:
	return _skills_dict_by_enum[e]
