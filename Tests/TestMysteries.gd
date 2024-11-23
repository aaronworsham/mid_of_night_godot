extends GutTest

@onready var mysteries_resource:MysteryResource = MysteryResource.new()
@onready var mysteries_json:JSON = load("res://Tests/test_mysteries_strapi.json")
var mystery_key 
var clue_key 
var mystery_dialogic_key 
var mystery_guid 
var clue_dialogic_key
var clue_guid


func before_each():

	mysteries_resource.json = mysteries_json
	mysteries_resource.on_load()
	mystery_key = mysteries_resource._mysteries_array[0]["key"]
	clue_key = mysteries_resource._mysteries_array[0]["clues"][0]["key"]
	mystery_dialogic_key = mysteries_resource._mysteries_array[0]["dialogic_signal_key"]
	mystery_guid = mysteries_resource._mysteries_array[0]["guid"]
	clue_dialogic_key = mysteries_resource._mysteries_array[0]["clues"][0]["dialogic_signal_key"]
	clue_guid = mysteries_resource._mysteries_array[0]["clues"][0]["guid"]

func test_json():
	assert_not_null(mysteries_resource.json)
	assert_not_null(mysteries_resource._mysteries_dict)
	assert_not_null(mysteries_resource.get_mysteries_as_dict())

func test_mysteries_as_dict():
	var tmp:Dictionary = mysteries_resource.get_mysteries_as_dict()
	assert_eq(tmp.keys().size(), 2)
	assert_eq(tmp.keys()[0], mystery_key)

func test_mysteries_as_array():
	var tmp = mysteries_resource.get_mysteries_as_array()
	assert_eq(tmp.size(), 2)
	assert_eq(tmp[0]["key"], mystery_key)

func test_get_mystery_keys():
	var tmp:Array = mysteries_resource.get_mystery_keys()
	assert_eq(tmp.size(), 2)
	assert_eq(tmp[0], mystery_key)


func test_get_mystery_by_key():
	var tmp:Dictionary = mysteries_resource.get_mystery_by_key(mystery_key)
	assert_eq(tmp["key"], mystery_key)

func test_fail_to_get_mystery_by_key():
	var tmp:Dictionary = mysteries_resource.get_mystery_by_key("bad_key")
	assert_true(tmp.is_empty())

func test_get_mystery_by_guid():
	var tmp:Dictionary = mysteries_resource.get_mystery_by_guid(mystery_guid)
	assert_eq(tmp["guid"], mystery_guid)

func test_fail_get_mystery_by_guid():
	var tmp:Dictionary = mysteries_resource.get_mystery_by_guid("bad_key")
	assert_true(tmp.is_empty())

func test_get_discovered_mysteries():
	var tmp:Array = mysteries_resource.get_discovered_mysteries()
	assert_eq(tmp.size(), 0)
	mysteries_resource.set_mystery_as_discovered(mystery_key)
	var tmp2:Array = mysteries_resource.get_discovered_mysteries()
	assert_eq(tmp2.size(),1)
	assert_eq(tmp2[0]["key"], mystery_key)

func test_get_mystery_from_dialogic_signal_key():
	var tmp:Dictionary = mysteries_resource.get_mystery_from_dialogic_signal_key(mystery_dialogic_key)
	assert_eq(tmp["key"], mystery_key)

func test_get_clues():
	var tmp:Array = mysteries_resource.get_clues_for_mystery(mystery_key)
	assert_eq(tmp.size(), 2)

func test_get_clue_from_dialogic_signal_key():
	var c:Dictionary = mysteries_resource.get_clue_from_dialogic_signal_key(clue_dialogic_key)
	assert_eq(c["key"], clue_key)

func test_get_clue_by_key():
	var clue:Dictionary = mysteries_resource.get_clue_by_key(clue_key)
	assert_eq(clue["key"], clue_key) 

func test_fail_to_get_clue_by_key():
	var clue:Dictionary = mysteries_resource.get_clue_by_key("bad_key")
	assert_true(clue.is_empty())

func test_get_clue_by_guid():
	var clue:Dictionary = mysteries_resource.get_clue_by_guid(clue_guid)
	assert_eq(clue["guid"], clue_guid) 

func test_fail_to_get_clue_by_guid():
	var clue:Dictionary = mysteries_resource.get_clue_by_guid("bad_key")
	assert_true(clue.is_empty())


func test_set_clue_as_discovered():
	assert_false(mysteries_resource.is_clue_discovered(clue_key))
	mysteries_resource.set_clue_as_discovered(clue_key)
	assert_true(mysteries_resource.is_clue_discovered(clue_key))

func test_get_discovered_clues():
	assert_eq(mysteries_resource.get_discovered_clues().size(), 0)
	mysteries_resource.set_clue_as_discovered(clue_key)
	assert_eq(mysteries_resource.get_discovered_clues().size(), 1)

func test_discovery_references():
	assert_false(mysteries_resource._mysteries_dict[mystery_key]["state"]["discovered"])
	assert_false(mysteries_resource.is_mystery_discovered(mystery_key))
	var tmp1:Array = mysteries_resource.get_discovered_mysteries()
	assert_eq(tmp1.size(), 0)
	assert_false(mysteries_resource.json.data.data[0]["state"]["discovered"])
	assert_false(mysteries_json.data.data[0]["state"]["discovered"])

	mysteries_resource.set_mystery_as_discovered(mystery_key)
	
	#_mysteries_dict is updated by reference
	assert_true(mysteries_resource._mysteries_dict[mystery_key]["state"]["discovered"])
	assert_true(mysteries_resource.is_mystery_discovered(mystery_key))
	var tmp2:Array = mysteries_resource.get_discovered_mysteries()
	
	#_discovered_mysteries array is updated by reference
	assert_eq(tmp2.size(), 1)
	assert_eq(tmp2[0]["key"], mystery_key)
	assert_true(tmp2[0]["state"]["discovered"])
	
	#json.data.data is NOT updated by reference
	assert_false(mysteries_resource.json.data.data[0]["state"]["discovered"])
	assert_false(mysteries_json.data.data[0]["state"]["discovered"])












	
