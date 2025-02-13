class_name TestDialogCollection extends BaseTestCollection

@onready var dialog_resource:DialogCollectionResource = DialogCollectionResource.new()
@onready var dialog_json:JSON = load ("res://Tests/StrapiData/Collections/test_dialogs.collection.strapi.json")

var mguid:String

func before_each():
    setup_collection(dialog_resource,dialog_json)
    mguid = collection_resource._collection_array[0]["mystery"]["guid"]

func test_setup():
    base_test_setup()

func test_get_clue_by_guid():
    var d:Dictionary = dialog_resource.get_member_by_guid(cguid)
    assert_eq(d["name"], cname)
