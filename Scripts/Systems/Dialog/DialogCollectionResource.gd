class_name DialogCollectionResource extends Resource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _dialogs_array:Array

#references to _dialogs_array by guid
var _dialogs_dict:Dictionary


func on_load():
    
    _dialogs_array.clear()

    #source of truth
    _dialogs_array = json.data.data.duplicate(true)

    for t in _dialogs_array:
        _dialogs_dict[t["guid"]] = t

func get_dialog_by_guid(guid:String) -> Dictionary:
    return _dialogs_dict[guid]

