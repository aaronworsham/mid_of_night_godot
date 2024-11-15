extends GutTest

@onready var mysteries_resource:MysteryResource = MysteryResource.new()
@onready var mysteries_json:JSON = load("res://Tests/TestMysteries.json")
var m_key = "the_village_mystery_1"
var c_guid = "the_village_mystery_1#clue_1"


func before_each():

	mysteries_resource.json = mysteries_json
	mysteries_resource.on_load()

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
	mysteries_resource.set_mystery_as_discovered(m_key)
	var tmp2:Array = mysteries_resource.get_discovered_mysteries()
	assert_eq(tmp2.size(),1)
	assert_eq(tmp2[0]["guid"], "the_village_mystery_1")

func test_get_description():
	assert_eq(m_key, "the_village_mystery_1")
	var desc:String = mysteries_resource.get_description(m_key)
	assert_eq(desc,"The Village")

func test_get_mystery_from_dialogic_signal_key():
	var d_key = "Vendor_Actor_1/Mystery/the_village"
	var tmp:Dictionary = mysteries_resource.get_mystery_from_dialogic_signal_key(d_key)
	assert_eq(tmp["guid"], "the_village_mystery_1")

func test_get_clues():
	var tmp:Array = mysteries_resource.get_clues_for_mystery(m_key)
	assert_eq(tmp.size(), 2)

func test_get_clue_from_dialogic_signal_key():
	var d_key = "Vendor_Actor_1/Mystery/the_village_mystery_1/Clue/clue_1"
	var c:Dictionary = mysteries_resource.get_clue_from_dialogic_signal_key(d_key)
	assert_eq(c["guid"], c_guid)

func test_get_clue_by_guid():
	var guid:String = "the_village_mystery_1#clue_1"
	var clue:Dictionary = mysteries_resource.get_clue_by_guid(guid)
	assert_eq(clue["guid"], guid) 

func test_set_clue_as_discovered():
	assert_false(mysteries_resource.is_clue_discovered(c_guid))
	mysteries_resource.set_clue_as_discovered(c_guid)
	assert_true(mysteries_resource.is_clue_discovered(c_guid))

func test_get_discovered_clues():
	assert_eq(mysteries_resource.get_discovered_clues().size(), 0)
	mysteries_resource.set_clue_as_discovered(c_guid)
	assert_eq(mysteries_resource.get_discovered_clues().size(), 1)

func test_discovery_references():
	assert_false(mysteries_resource._mysteries_dict[m_key]["state"]["discovered"])
	assert_false(mysteries_resource.is_mystery_discovered(m_key))
	var tmp1:Array = mysteries_resource.get_discovered_mysteries()
	assert_eq(tmp1.size(), 0)

	mysteries_resource.set_mystery_as_discovered(m_key)
	
	assert_true(mysteries_resource._mysteries_dict[m_key]["state"]["discovered"])
	assert_true(mysteries_resource.is_mystery_discovered(m_key))
	var tmp2:Array = mysteries_resource.get_discovered_mysteries()
	assert_eq(tmp2.size(), 1)
	assert_eq(tmp2[0]["guid"], m_key)
	assert_true(tmp2[0]["state"]["discovered"])










	
