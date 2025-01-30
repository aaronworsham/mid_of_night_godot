extends GutTest

@onready var mysteries_resource:MysteryCollectionResource = MysteryCollectionResource.new()
@onready var mysteries_json:JSON = load ("res://Tests/StrapiData/Collections/test_mysteries.collection.strapi.json")

var guid:String
var dname:String

func before_each():
    mysteries_resource.json = mysteries_json
    mysteries_resource.on_load()
    guid = mysteries_resource._mysteries_array[0]["guid"]
    dname = mysteries_resource._mysteries_array[0]["name"]

func test_setup():
    assert_not_null(mysteries_resource.json.data)
    assert_not_null(mysteries_resource._mysteries_dict)

func test_get_mystery_by_guid():
    var d:Dictionary = mysteries_resource.get_mystery_by_guid(guid)
    assert_eq(d["name"], dname)
