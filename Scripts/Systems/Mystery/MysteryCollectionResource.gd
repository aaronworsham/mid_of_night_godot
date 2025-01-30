class_name MysteryCollectionResource extends Resource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _mysteries_array:Array

#references to _mysteries_array by guid
var _mysteries_dict:Dictionary


func on_load():
    
    _mysteries_array.clear()

    #source of truth
    _mysteries_array = json.data.data.duplicate(true)

    for t in _mysteries_array:
        _mysteries_dict[t["guid"]] = t

func get_mystery_by_guid(guid:String) -> Dictionary:
    return _mysteries_dict[guid]

func get_all_discovered_mysteries()-> Array:
    return _mysteries_array