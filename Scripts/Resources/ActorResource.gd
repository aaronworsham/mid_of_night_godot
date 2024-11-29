class_name ActorResource extends Resource

@export var guid:String
@export var name:String

func save()->Dictionary:
	var save_dict = {
		"name":name
	}
	return save_dict
