class_name ClueCollectionResource extends Resource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _clues_array:Array

#references to _clues_array by guid
var _clues_dict:Dictionary


func on_load():
    
    _clues_array.clear()

    #source of truth
    _clues_array = json.data.data.duplicate(true)

    for t in _clues_array:
        _clues_dict[t["guid"]] = t

func get_clue_by_guid(guid:String) -> Dictionary:
    return _clues_dict[guid]