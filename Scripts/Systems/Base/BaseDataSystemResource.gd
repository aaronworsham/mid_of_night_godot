class_name BaseDataSystemResource extends BaseResource

# [MemberCollection] is an array of <Members>.  Each <Member> can have multiple <SubMembers>.  [SubMemberCollection] is an array of <SubMembers>

@export var member_json:JSON:
    set(value):
        member_json = value
@export var submember_json:JSON:
    set(value):
        submember_json = value

#source of truth (direct from json)
var _member_array:Array
var _submember_array:Array

#references to _member_collection_array by guid
var _member_dict:Dictionary
var _submember_dict:Dictionary


func on_load():
    
    _member_array.clear()
    _submember_array.clear()

    #source of truth
    _member_array = member_json.data.data.duplicate(true)
    _submember_array = submember_json.data.data.duplicate(true)

    for t in _member_array:
        _member_dict[t["guid"]] = t

    for t in _submember_array:
        _submember_dict[t["guid"]] = t

func get_member_by_guid(guid:String) -> Dictionary:
    return _member_dict[guid]

func get_submember_by_guid(guid:String) -> Dictionary:
    return _submember_dict[guid]
