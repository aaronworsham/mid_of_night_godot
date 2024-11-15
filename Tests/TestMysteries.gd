extends GutTest

@onready var mysteries_resource:MysteryResource = MysteryResource.new()
@onready var mysteries_json:JSON = load("res://Tests/TestMysteries.json")
var key:String


func before_all():
	mysteries_resource.json = mysteries_json
	mysteries_resource.on_load()
	key = mysteries_resource.get_mystery_keys()[0]

func test_json():
	assert_not_null(mysteries_resource.json)
	assert_not_null(mysteries_resource._mysteries_dict)
	assert_not_null(mysteries_resource.get_mysteries_as_dict())

func test_mysteries_as_dict():
	var tmp:Dictionary = mysteries_resource.get_mysteries_as_dict()
	assert_eq(tmp.keys().size(), 2)
	assert_eq(tmp.keys()[0], "the_village_mystery_1")

func test_mysteries_as_array():
	var tmp = mysteries_resource.get_mysteries_as_array()
	assert_eq(tmp.size(), 2)
	assert_eq(tmp[0]["description"], "The Village")

func test_get_mystery_keys():
	var tmp:Array = mysteries_resource.get_mystery_keys()
	assert_eq(tmp.size(), 2)
	assert_eq(tmp[0], "the_village_mystery_1")

func test_get_discovered_mysteries():
	var tmp:Array = mysteries_resource.get_discovered_mysteries()
	assert_eq(tmp.size(), 0)
	mysteries_resource.set_mystery_as_discovered(key)
	var tmp2:Array = mysteries_resource.get_discovered_mysteries()
	assert_eq(tmp2.size(),1)
	assert_eq(tmp2[0]["guid"], "the_village_mystery_1")

func test_get_description():
	assert_eq(key, "the_village_mystery_1")
	var desc:String = mysteries_resource.get_description(key)
	assert_eq(desc,"The Village")

func test_get_mystery_from_dialogic_signal_key():
	var d_key = "Vendor_Actor_1/Mystery/the_village"
	var tmp:Dictionary = mysteries_resource.get_mystery_from_dialogic_signal_key(d_key)
	assert_eq(tmp["guid"], "the_village_mystery_1")

func test_get_clues():
	var tmp:Array = mysteries_resource.get_clues_for_mystery(key)
	assert_eq(tmp.size(), 2)

func test_get_clue_from_dialogic_signal_key():
	var d_key = "Vendor_Actor_1/Mystery/the_village_mystery_1/Clue/clue_1"
	var c:Dictionary = mysteries_resource.get_clue_from_dialogic_signal_key(d_key)
	assert_eq(c["key"], "clue_1")








	
