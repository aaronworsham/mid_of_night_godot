extends GutTest

@onready var clues_resource:ClueCollectionResource = ClueCollectionResource.new()
@onready var clues_json:JSON = load ("res://Data/StrapiData/Collections/clues.collection.strapi.json")

var guid:String
var dname:String
var mguid:String

func before_each():
    clues_resource.json = clues_json
    clues_resource.on_load()
    guid = clues_resource._clues_array[0]["guid"]
    dname = clues_resource._clues_array[0]["name"]
    mguid = clues_resource._clues_array[0]["mystery"]["guid"]

func test_setup():
    assert_not_null(clues_resource.json.data)
    assert_not_null(clues_resource._clues_dict)

func test_get_clue_by_guid():
    var d:Dictionary = clues_resource.get_clue_by_guid(guid)
    assert_eq(d["name"], dname)

func test_clues_by_myster():
    var a:Array = clues_resource.get_clues_by_mystery(mguid)
    assert_eq(a.size(), 1)
    assert_eq(a[0]["guid"], guid)
