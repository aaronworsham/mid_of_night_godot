class_name ClueCollectionResource extends BaseCollectionResource


#reference to _clues_array by mystery guid
var _clues_dict_by_mystery:Dictionary = {}

func on_load():

    super()
    
    for t in _collection_array:
        if !_clues_dict_by_mystery.has(t["mystery"]["guid"]):
            _clues_dict_by_mystery[t["mystery"]["guid"]] = []
        _clues_dict_by_mystery[t["mystery"]["guid"]].append(t)
  

func get_clues_by_mystery(mguid:String) -> Array:
    return _clues_dict_by_mystery[mguid]
