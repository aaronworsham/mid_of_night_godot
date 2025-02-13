class_name BaseTestDataSystem extends GutTest

@export var data_system_resource:Resource:
    set(value):
        data_system_resource = value

var first_member_guid:String
var first_member_name:String
var first_submember_guid:String
var first_submember_name:String


func base_setup():
    first_member_guid = data_system_resource._member_array[0]["guid"]
    first_member_name = data_system_resource._member_array[0]["name"]
    first_submember_guid = data_system_resource._submember_array[0]["guid"]
    first_submember_name = data_system_resource._submember_array[0]["name"]

func base_test_setup():
    assert_not_null(data_system_resource.member_json.data)
    assert_not_null(data_system_resource.submember_json.data)
    