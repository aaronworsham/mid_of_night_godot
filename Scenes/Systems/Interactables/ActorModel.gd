class_name ActorModel extends Node

@export var actor_resource:ActorMemberResource:
	set(value):
		actor_resource = value


func get_actor_name()->String:
	return actor_resource.get_actor_name()

func get_guid()->String:
	return actor_resource.get_guid()

func get_coords()->Vector2:
	return actor_resource.get_coords()

func get_portrait_path()->String:
	return actor_resource.get_portrait_64_path()

func get_portrait_256_path()->String:
	return actor_resource.get_portrait_256_path()

func get_dialog_guid()->String:
	return actor_resource.get_dialog_guid()
