extends GutTest

@onready var actor_resource:ActorResource = ActorResource.new()
@onready var actor_json:JSON = load ("res://Tests/StrapiData/Collections/test_actors.collection.strapi.json")

func before_each():
	actor_resource.json = actor_json
	actor_resource.on_load()

func test_setup():
	assert_not_null(actor_resource.json.data)
