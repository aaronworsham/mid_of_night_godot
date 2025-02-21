class_name BaseDataSystemResource extends BaseResource

# [MemberCollection] is an array of <Members>.  Each <Member> can have multiple <SubMembers>.  [SubMemberCollection] is an array of <SubMembers>

@export var member_json:JSON:
    set(value):
        member_json = value
@export var submember_json:JSON:
    set(value):
        submember_json = value
@export var member_string:String:
    set(value):
        member_string = value
@export var members_string:String:
    set(value):
        members_string = value
@export var submember_string:String:
    set(value):
        submember_string = value
@export var submembers_string:String:
    set(value):
        submembers_string = value


#source of truth (direct from json)
var _member_array:Array
var _submember_array:Array

#references to _member_collection_array by guid
var _member_dict:Dictionary
var _submember_dict:Dictionary
var _submembers_by_member_guid:Dictionary

#discovered Array lists 
var _members_discovered:Array
var _submembers_discovered:Array


func on_load():
    
    _member_array.clear()
    _submember_array.clear()
    _submembers_by_member_guid.clear()
    _members_discovered.clear()
    _submembers_discovered.clear()

    #source of truth
    _member_array = member_json.data.data.duplicate(true)
    _submember_array = submember_json.data.data.duplicate(true)

    for t in _member_array:
        _member_dict[t["guid"]] = t


    for t in _submember_array:
        _submember_dict[t["guid"]] = t

    for t in _submember_array:
        _submembers_by_member_guid[t["guid"]] = t 
        if _submembers_by_member_guid.has(t[member_string]["guid"]):
            _submembers_by_member_guid[t[member_string]["guid"]].append(t)
        else: 
            _submembers_by_member_guid[t[member_string]["guid"]] = []           
            _submembers_by_member_guid[t[member_string]["guid"]].append(t)

    #TODO: Create Persistant list of Discovered Members and Submembers

func get_member_by_guid(guid:String) -> Dictionary:
    return _member_dict[guid]

func get_submember_by_guid(guid:String) -> Dictionary:
    return _submember_dict[guid]

func get_submembers_from_member_guid(guid:String) -> Array:
    if _submembers_by_member_guid.has(guid):
        return _submembers_by_member_guid[guid]
    else:
        return []

func set_member_as_discovered(guid:String):
    if !_members_discovered.has(guid):
        _members_discovered.append(guid)

func set_member_as_undiscovered(guid:String):
    if _members_discovered.has(guid):
        _members_discovered.erase(guid)


func is_member_discovered(guid:String)->bool:
    return _members_discovered.has(guid)

func set_submember_as_discovered(guid:String):
    if !_submembers_discovered.has(guid):
        _submembers_discovered.append(guid)

func set_submember_as_undiscovered(guid:String):
    if _submembers_discovered.has(guid):
        _submembers_discovered.erase(guid)


func is_submember_discovered(guid:String)->bool:
    return _submembers_discovered.has(guid)
