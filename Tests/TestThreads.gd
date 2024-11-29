extends GutTest

@onready var thread_resource:Resource = ThreadResource.new()
@onready var thread_json:JSON = load ("res://Tests/test_threads.strapi.json")


var thread_key:String
var thread_guid:String

func before_each():
	thread_resource.json = thread_json
	thread_resource.on_load()
	thread_key = thread_resource._threads_array[0]["thread_key"]
	thread_guid = thread_resource._threads_array[0]["guid"]

func test_setup():
	assert_not_null(thread_resource.json.data)
	assert_not_null(thread_resource._threads_dict_by_key)
	assert_not_null(thread_resource._threads_dict_by_guid)
	assert_not_null(thread_resource._threads_array)

func test_get_instructions():
	var tmpD:Dictionary = thread_resource.get_all_parsed_instructions_by_thread_guid()
	assert_not_null(tmpD)
	assert_true(tmpD.has(thread_guid))

func test_instructions_by_key():
	var tmp:Array = thread_resource.get_parsed_instructions_for_key(thread_key)
	assert_eq(tmp.size(), 5)
	assert_eq(tmp[0], "label vendor_hello")
	assert_eq(tmp[1], "Hello young fella.  Here to learn more about [The Village (Info)] ?")
	assert_eq(tmp[2], "[signal arg='thread_key:vendor_hello|category_key:the_village_thread']")
	assert_eq(tmp[4], "[end_timeline]")


func test_dialogic_events():
	var tmp:Array = thread_resource.get_parsed_instructions_for_key(thread_key)
	assert_true(tmp.size() > 0)
	var timeline:DialogicTimeline = DialogicTimeline.new()
	timeline.events = tmp
	assert_false(timeline.events_processed)
	timeline.process()
	assert_true(timeline.events_processed)

func test_get_timeline():
	var tmpTL:DialogicTimeline = thread_resource.get_timeline(thread_key)
	assert_true(tmpTL.events.size() > 0)
