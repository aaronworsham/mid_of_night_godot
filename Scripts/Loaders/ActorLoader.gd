class_name ActorLoader extends Node

@onready var actors_collection_resource:ActorCollectionResource = ActorCollectionResource.new()
@onready var actor_resource:ActorMemberResource = ActorMemberResource.new()
@onready var actor_json:JSON = load ("res://Tests/StrapiData/Collections/test_actors.collection.strapi.json")
@onready var models_container:Node = %Models
@onready var actor_template = preload("res://Scenes/Interactables/Actors/ActorTemplate.tscn")

func _ready() -> void:
    actors_collection_resource.json = actor_json
    actors_collection_resource.on_load()
    var _actors = actors_collection_resource.get_all_actors()
    for a in _actors:
        print("creating an Actor")
        var actor_instance = actor_template.instantiate()
        var label:Label = actor_instance.find_child("ActorLabel")
        label.text = a["name"]
        add_child(actor_instance)
