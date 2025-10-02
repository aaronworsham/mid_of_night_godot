class_name SkillMemberResource extends Resource

var _enum:String
var _guid:String
var _name:String
var _description:String
var _associated_attribute:String
var _default_value:int
var _current_value:int


func setup(skill:Dictionary):
    _enum = skill["enum"]
    _guid = skill["guid"]
    _name = skill["name"]
    _description = skill["description"]
    _associated_attribute = skill["associated_attribute"]
    _default_value = int(skill["default_value"])
    _current_value = _default_value

func get_enum()->String:
    return _enum

func get_guid()->String:
    return _guid

func get_skill_name()->String:
    return _name    

func get_description()->String:
    return _description

func get_associated_attribute()->String:
    return _associated_attribute

func get_default_value()->int:
    return _default_value

func get_current_value()->int:
    return _current_value

func set_current_value(val:int)->void:
    _current_value = val
    if _current_value < 0:
        _current_value = 0
    
func reset_current_value()->void:
    _current_value = _default_value 
