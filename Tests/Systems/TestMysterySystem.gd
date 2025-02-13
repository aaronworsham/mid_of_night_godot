class_name TestMysterySystem extends BaseTestDataSystem

var resource:MysterySystemResource = MysterySystemResource.new()
var mguid:String

func before_each():
    resource.on_load()
    data_system_resource = resource
    base_setup()


func test_setup():
    base_test_setup()

func test_get_mystery_by_guid():
    var m:Dictionary = resource.get_member_by_guid(first_member_guid)
    assert_eq(m["name"], first_member_name)

func test_get_clue_by_guid():
    var c:Dictionary = resource.get_submember_by_guid(first_submember_guid)
    assert_eq(c["name"], first_submember_name)

func test_get_clue_from_mystery():
    var m:Dictionary = resource.get_member_by_guid(first_member_guid)
    var c:Dictionary = resource.get_submember_by_guid(m["clues"][0]["guid"])
    assert_eq(c["name"], first_submember_name)
