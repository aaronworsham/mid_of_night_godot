extends GutTest

@onready var dialog_resource:DialogResource = DialogResource.new()
@onready var dialog_json:JSON = load ("res://Tests/test_dialogs.strapi.json")
var timeline_name:String

func before_each():
	dialog_resource.json = dialog_json
	dialog_resource.on_load()
	timeline_name = "test_timeline"

func test_setup():
	assert_not_null(dialog_resource.json.data)
	assert_not_null(dialog_resource._dialogs_dict)
	assert_not_null(dialog_resource._dialogs_array)

func test_instructions():
	var tmp:Array = dialog_resource.get_instructions(timeline_name)
	assert_true(tmp.size() > 0)

func test_dialogic_events():
	var tmp:Array = dialog_resource.get_instructions(timeline_name)
	assert_true(tmp.size() > 0)
	var timeline:DialogicTimeline = DialogicTimeline.new()
	timeline.events = tmp
	assert_false(timeline.events_processed)
	timeline.process()
	assert_true(timeline.events_processed)
