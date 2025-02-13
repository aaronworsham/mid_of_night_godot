class_name BaseCollectionResource extends BaseResource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _collection_array:Array

#references to _collection_array by guid
var _collection_dict:Dictionary


func on_load():
    
    _collection_array.clear()

    #source of truth
    _collection_array = json.data.data.duplicate(true)

    for t in _collection_array:
        _collection_dict[t["guid"]] = t

func get_member_by_guid(guid:String) -> Dictionary:
    return _collection_dict[guid]
