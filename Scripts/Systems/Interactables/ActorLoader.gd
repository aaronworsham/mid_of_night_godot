class_name ActorLoader extends Node

@onready var actors_collection_resource:ActorCollectionResource = ActorCollectionResource.new()
@onready var actor_json:JSON = load ("res://Data/StrapiData/Collections/actors.collection.strapi.json")
@onready var actors_container:Node = %Actors
@onready var actor_template = preload("res://Scenes/Interactables/Actors/ActorTemplate.tscn")

func _ready() -> void:
    actors_collection_resource.json = actor_json
    actors_collection_resource.on_load()
    var _actors = actors_collection_resource.get_all_actors()
    var test_actor_skipped = false
    for a in _actors:
        if !test_actor_skipped:
            test_actor_skipped = true
            continue
        var actor_resource:ActorMemberResource = ActorMemberResource.new()
        actor_resource.setup(a)

        

        var actor_model:ActorModel = ActorModel.new()
        actor_model.actor_resource = actor_resource

        var actor_instance:StaticBody2D = actor_template.instantiate()
        #Send actor model to the View
        actor_instance.save_actor(actor_model)

        #Move the Actor to the right location
        actor_instance.position = actor_model.get_coords()

        #Give the Actor the right Label
        var label:Label = actor_instance.find_child("ActorLabel")
        label.text = actor_model.get_actor_name()

        #Give the Actor the right image
        var portrait:Sprite2D = actor_instance.find_child("ActorPortrait")
        var portraitTexture:Texture = load(actor_model.get_portrait_path())
        portrait.texture = portraitTexture      

        actors_container.add_child(actor_instance)
        EventManager.event_actor_loaded.emit(actor_model)
