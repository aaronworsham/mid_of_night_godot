class_name ActorModel extends Node

@export var actor_resource:ActorMemberResource:
    set(value):
        actor_resource = value

func get_actor_name()->String:
    return actor_resource.get_member_name()