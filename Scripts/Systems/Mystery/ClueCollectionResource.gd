class_name ClueCollectionResource extends Resource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _clues_array:Array = []

#references to _clues_array by guid
var _clues_dict:Dictionary = {}

#reference to _clues_array by mystery guid
var _clues_dict_by_mystery:Dictionary = {}

func on_load():
    
    _clues_array.clear()
    _clues_dict.clear()
    _clues_dict_by_mystery.clear()

    #source of truth
    _clues_array = json.data.data.duplicate(true)

    for c in _clues_array:
        _clues_dict[c["guid"]] = c
        if !_clues_dict_by_mystery.has(c["mystery"]["guid"]):
            _clues_dict_by_mystery[c["mystery"]["guid"]] = []
        _clues_dict_by_mystery[c["mystery"]["guid"]].append(c)

func get_clue_by_guid(guid:String) -> Dictionary:
    return _clues_dict[guid]

func get_clues_by_mystery(mguid:String) -> Array:
    return _clues_dict_by_mystery[mguid]
