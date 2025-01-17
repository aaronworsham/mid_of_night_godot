extends GutTest

@onready var threads_resource:ThreadCollectionResource = ThreadCollectionResource.new()
@onready var threads_json:JSON = load ("res://Tests/StrapiData/Collections/test_threads.collection.strapi.json")

var guid:String
var tname:String
var dguid:String

func before_each():
    threads_resource.json = threads_json
    threads_resource.on_load()
    guid = threads_resource._threads_array[0]["guid"]
    tname = threads_resource._threads_array[0]["name"]
    dguid = threads_resource._threads_array[0]["dialog"]["guid"]

func test_setup():
    assert_not_null(threads_resource.json.data)
    assert_not_null(threads_resource._threads_dict_by_guid)

func test_get_thread_by_guid():
    var d:Dictionary = threads_resource.get_thread_by_guid(guid)
    assert_eq(d["name"], tname)

func test_get_threads_by_dialog_guid():
    var a:Array = threads_resource.get_threads_by_dialog_guid(dguid)
    assert_not_null(a)
    assert_eq(a.size(), 1)
    assert_eq(a[0]["guid"], guid)
