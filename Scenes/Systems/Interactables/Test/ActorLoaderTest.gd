class_name ActorLoaderTest extends Node

@onready var actors_collection_resource:ActorCollectionResource = ActorCollectionResource.new()
@onready var actor_json:JSON = load ("res://Data/StrapiData/Collections/actors.collection.strapi.json")
@onready var actors_container:Node = $/root/ActorSelectorSceneTest/Objects/Actors
@onready var actor_template = preload("res://Scenes/Systems/Interactables/Test/ActorTemplateTest.tscn")

@export var _x_currentXCord:int = 0
@export var _y_currentYCord:int = 0

func _ready() -> void:
	actors_collection_resource.json = actor_json
	actors_collection_resource.on_load()
	var _actors = actors_collection_resource.get_all_actors() 
	for a in _actors:
		var actor_resource:ActorMemberResource = ActorMemberResource.new()
		actor_resource.setup(a)

		var actor_model:ActorModel = ActorModel.new()
		actor_model.actor_resource = actor_resource

		var actor_instance:StaticBody2D = actor_template.instantiate()
		#Send actor model to the View
		actor_instance.save_actor(actor_model)

		#Move the Actor to the right location
		actor_instance.position = Vector2(_x_currentXCord,_y_currentYCord)
		_x_currentXCord += 100


		#Give the Actor the right Label
		var label:Label = actor_instance.find_child("ActorLabel")
		label.text = actor_model.get_actor_name()

		#Give the Actor the right image
		var portrait:Sprite2D = actor_instance.find_child("ActorPortrait")
		var portraitTexture:Texture = load(actor_model.get_portrait_path())
		portrait.texture = portraitTexture      

		actors_container.add_child(actor_instance)
		EventManager.event_actor_loaded.emit(actor_model)
