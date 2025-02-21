class_name ThreadCollectionResource extends BaseResource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _threads_array:Array

#references to _threads_array
var _threads_dict_by_guid:Dictionary
var _submembers_by_member_guid:Dictionary

#persistable Values
var _threads_persist_dict_by_guid:Dictionary
var _threads_discovered_array:Array

func on_load():
    
    _threads_array.clear()
    _threads_dict_by_guid.clear()
    _submembers_by_member_guid.clear()
    _threads_persist_dict_by_guid.clear()
    _threads_discovered_array.clear()

    #source of truth
    _threads_array = json.data.data.duplicate(true)

    for t in _threads_array:
        _threads_dict_by_guid[t["guid"]] = t 
        if _submembers_by_member_guid.has(t["dialog"]["guid"]):
            _submembers_by_member_guid[t["dialog"]["guid"]].append(t)
        else: 
            _submembers_by_member_guid[t["dialog"]["guid"]] = []           
            _submembers_by_member_guid[t["dialog"]["guid"]].append(t)

func get_thread_by_guid(guid:String)->Dictionary:
    return _threads_dict_by_guid[guid]

func get_threads_by_dialog_guid(guid:String)->Array:
    return _submembers_by_member_guid[guid]

func set_thread_as_discovered(guid:String):
    if !_threads_persist_dict_by_guid.has(guid):
        set_thread_persist_default(guid)
    _threads_persist_dict_by_guid[guid]["discovered"] = true
    _threads_discovered_array.append(get_thread_by_guid(guid))

func set_thread_persist_default(guid:String):

    if !_threads_persist_dict_by_guid.has(guid):
        _threads_persist_dict_by_guid[guid] = {
            "discovered" : false,
            "clicked" : false
        }

func is_thread_discovered(guid:String) -> bool:
    if !_threads_persist_dict_by_guid.has(guid):
        set_thread_persist_default(guid) 
        return false
    return _threads_persist_dict_by_guid[guid]["discovered"] 

func get_discovered_threads()->Array:
    return _threads_discovered_array
