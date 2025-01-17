extends GutTest

@onready var thread_resource:ThreadCollectionResource = ThreadCollectionResource.new()
@onready var thread_json:JSON = load ("res://Tests/test_threads.strapi.json")
@onready var timeline_resource:TimelineResource = TimelineResource.new()

var actor_key:String
var actor_guid:String

# func before_each():
# 	thread_resource.json = thread_json
# 	thread_resource.on_load()
	
# 	timeline_resource._threads_resource = thread_resource
# 	timeline_resource.on_load()
# 	actor_key = thread_resource._threads_array[0]["actor"]["key"]
# 	actor_guid = thread_resource._threads_array[0]["actor"]["guid"]

# func test_setup():
# 	assert_not_null(thread_resource.json.data)
# 	assert_not_null(thread_resource._threads_dict_by_key)
# 	assert_not_null(thread_resource._threads_dict_by_guid)
# 	assert_not_null(thread_resource._threads_array)
# 	assert_not_null(timeline_resource._threads_resource)
# 	assert_not_null(timeline_resource._timelines_array)
# 	assert_not_null(timeline_resource._timelines_dict_by_actor_key)
# 	assert_not_null(timeline_resource._timelines_dict_by_actor_guid)

# func test_instructions_by_actor_guid():
# 	var tmpD:Dictionary = timeline_resource.get_threads_for_actor_guid(actor_guid)
# 	assert_true(tmpD.has("vendor_hello"))
