class_name SkillResource extends Resource

enum Skills {
    STRENGTH
} 

var skill_value =  {

    Skills.STRENGTH : 0

}

func get_skill_value(s:Skills) -> int:
    return skill_value[s]