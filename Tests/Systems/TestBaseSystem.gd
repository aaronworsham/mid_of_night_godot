class_name TestBaseSystem extends BaseTestDataSystem

var resource_array = [
    DialogSystemResource.new(),
    MysterySystemResource.new()
]
var mguid:String

func setup_resource(r:BaseDataSystemResource):
    r.on_test_load()
    data_system_resource = r
    base_setup()    

func test_setup():
    for r in resource_array:
        setup_resource(r)
        base_test_setup()

func test_get_dialog_by_guid():
    for r in resource_array:
        setup_resource(r)
        var m:Dictionary = r.get_member_by_guid(first_member_guid)
        assert_eq(m["name"], first_member_name)

func test_get_thread_by_guid():
    for r in resource_array:
        setup_resource(r)
        var c:Dictionary = r.get_submember_by_guid(first_submember_guid)
        assert_eq(c["name"], first_submember_name)

func test_get_thread_from_Dialog():
    for r in resource_array:
        setup_resource(r) 
        var m:Dictionary = r.get_member_by_guid(first_member_guid)
        var c:Dictionary = r.get_submember_by_guid(m[r.submembers_string][0]["guid"])
        assert_not_null(c)
