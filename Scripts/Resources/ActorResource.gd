class_name ActorResource
extends Resource

@export var name:String

func save()->Dictionary:
	var save_dict = {
		"name":name
	}
	return save_dict
