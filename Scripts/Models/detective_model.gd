class_name DetectiveModel
extends Node

enum AttributeNames {STRENGTH}

var _attributes = {
	AttributeNames.STRENGTH:5
}

func get_att(att:AttributeNames) -> int:
	return _attributes[att]

func set_att(att:AttributeNames,x:int) -> bool:
	_attributes[att] = x
	return true

func increase_att(att:AttributeNames,x:int) -> bool:
	_attributes[att] += x
	return true    

func decrease_att(att:AttributeNames, x:int) -> bool:
	_attributes[att] -= x
	return true  

func get_all_att() -> Dictionary:
	return _attributes


func save() -> Dictionary:
	var save_dict = {
		"filename" : get_scene_file_path(),
		"strength" : get_att(AttributeNames.STRENGTH)
	}
	return save_dict

func load(load_dict:Dictionary) -> bool:
	set_att(AttributeNames.STRENGTH,load_dict["strength"])
	return true
