class_name SkillsCollectionResource extends Resource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _skills_array:Array


func on_load():
    
    _skills_array.clear()

    #source of truth
    _skills_array = json.data.duplicate(true)


func get_all_skills()->Array:
    return _skills_array