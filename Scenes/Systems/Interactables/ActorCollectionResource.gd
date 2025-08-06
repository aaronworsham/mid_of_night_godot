class_name ActorCollectionResource extends Resource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _actors_array:Array

#Reference lookup by GUID
var _actors_dict_by_guid:Dictionary

func on_load():
    
    _actors_array.clear()
    _actors_dict_by_guid.clear()

    #source of truth
    _actors_array = json.data.data.duplicate(true)

    for t in _actors_array:
        _actors_dict_by_guid[t["guid"]] = t 
func get_all_actors()->Array:
    return _actors_array
