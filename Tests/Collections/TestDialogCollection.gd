extends GutTest

@onready var dialog_resource:DialogCollectionResource = DialogCollectionResource.new()
@onready var dialog_json:JSON = load ("res://Tests/StrapiData/Collections/test_dialogs.collection.strapi.json")

var guid:String
var dname:String

func before_each():
    dialog_resource.json = dialog_json
    dialog_resource.on_load()
    guid = dialog_resource._dialogs_array[0]["guid"]
    dname = dialog_resource._dialogs_array[0]["name"]

func test_setup():
    assert_not_null(dialog_resource.json.data)
    assert_not_null(dialog_resource._dialogs_dict)

func test_get_dialog_by_guid():
    var d:Dictionary = dialog_resource.get_dialog_by_guid(guid)
    assert_eq(d["name"], dname)
