class_name TestClueCollection extends BaseTestCollection

@onready var clues_resource:ClueCollectionResource = ClueCollectionResource.new()
@onready var clues_json:JSON = load ("res://Data/StrapiData/Collections/clues.collection.strapi.json")

var mguid:String

func before_each():
    setup_collection(clues_resource,clues_json)
    mguid = collection_resource._collection_array[0]["mystery"]["guid"]

func test_setup():
    base_test_setup()

func test_get_clue_by_guid():
    var d:Dictionary = clues_resource.get_member_by_guid(cguid)
    assert_eq(d["name"], cname)

func test_clues_by_myster():
    var a:Array = clues_resource.get_clues_by_mystery(mguid)
    assert_eq(a[0]["guid"], cguid)
