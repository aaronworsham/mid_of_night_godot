extends GutTest

@onready var actors_collection_resource:ActorCollectionResource = ActorCollectionResource.new()
@onready var actor_resource:ActorMemberResource = ActorMemberResource.new()
@onready var actor_json:JSON = load ("res://Tests/StrapiData/Collections/test_actors.collection.strapi.json")


var thread_guid:String = "testguid"
var _actors:Array 

func before_each():
    actors_collection_resource.json = actor_json
    actors_collection_resource.on_load()
    _actors = actors_collection_resource.get_all_actors()
    actor_resource.name = _actors[0]["name"]



func test_setup():
    assert_not_null(actors_collection_resource.json.data)
    assert_eq(actors_collection_resource._actors_array[0]["guid"],"testguid")
    assert_not_null(actors_collection_resource._actors_dict_by_guid["testguid"])

func test_actor_array():
    assert_eq(_actors.size(), 1)
    assert_eq(_actors[0]["name"], "TestActor")

func test_actor_resource():
    assert_eq(actor_resource.get_member_name(), "TestActor")
