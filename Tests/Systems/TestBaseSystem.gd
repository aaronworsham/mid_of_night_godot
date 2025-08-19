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

func test_get_member_by_guid():
	for r in resource_array:
		setup_resource(r)
		var m:Dictionary = r.get_member_by_guid(first_member_guid)
		assert_eq(m["name"], first_member_name)

func test_get_submember_by_guid():
	for r in resource_array:
		setup_resource(r)
		var c:Dictionary = r.get_submember_by_guid(first_submember_guid)
		assert_eq(c["name"], first_submember_name)

func test_get_submember_from_member():
	for r in resource_array:
		setup_resource(r) 
		var m:Dictionary = r.get_member_by_guid(first_member_guid)
		var c:Dictionary = r.get_submember_by_guid(m[r.submembers_string][0]["guid"])
		assert_not_null(c)

func test_no_discovered_members():
	for r in resource_array:
		setup_resource(r)
		assert_eq(r.get_discovered_members().size(), 0)

func test_set_member_as_discovered():
	for r in resource_array:
		setup_resource(r)
		r.set_member_as_discovered(first_member_guid)
		assert_eq(r.get_discovered_members().size(), 1)

func test_get_discovered_members():
	for r in resource_array:
		setup_resource(r)
		assert_eq(r.get_discovered_members().size(), 0)
		r.set_member_as_discovered(first_member_guid)
		r.set_member_as_discovered(second_member_guid)
		assert_eq(r.get_discovered_members().size(), 2)
		assert_eq(r.get_discovered_members()[0].guid, first_member_guid)
		assert_eq(r.get_discovered_members()[1].guid, second_member_guid)

func test_no_discovered_submembers():
	for r in resource_array:
		setup_resource(r)
		assert_eq(r.get_discovered_submembers().size(), 0)

func test_set_submember_as_discovered():
	for r in resource_array:
		setup_resource(r)
		assert_eq(r.get_discovered_submembers().size(), 0)
		r.set_submember_as_discovered(first_submember_guid)
		assert_eq(r.get_discovered_submembers().size(), 1)

func test_get_discovered_submembers():
	for r in resource_array:
		setup_resource(r)
		assert_eq(r.get_discovered_submembers().size(), 0)
		r.set_submember_as_discovered(first_submember_guid)
		r.set_submember_as_discovered(second_submember_guid)
		assert_eq(r.get_discovered_submembers().size(), 2)
		assert_eq(r.get_discovered_submembers()[0].guid, first_submember_guid)
		assert_eq(r.get_discovered_submembers()[1].guid, second_submember_guid)

func test_get_discovered_submembers_from_member():
	for r in resource_array:
		setup_resource(r)
		var m:Dictionary = r.get_member_by_guid(first_member_guid)
		var c:Dictionary = r.get_submember_by_guid(m[r.submembers_string][0]["guid"])
		assert_eq(c["name"], first_submember_name)
		assert_eq(r.get_discovered_submembers_by_member_guid(first_member_guid).size(), 0)
		r.set_submember_as_discovered(c["guid"])
		var s:Array = r.get_discovered_submembers_by_member_guid(first_member_guid)
		assert_eq(s.size(), 1)
		assert_eq(s[0].guid, c["guid"])

func test_get_discovered_submembers_by_member_guid():
	for r in resource_array:
		setup_resource(r)
		var s:Array = r.get_discovered_submembers_by_member_guid(first_member_guid)
		assert_eq(s.size(), 0)
		var m:Dictionary = r.get_member_by_guid(first_member_guid)
		r.set_submember_as_discovered(m[r.submembers_string][0]["guid"])
		s = r.get_discovered_submembers_by_member_guid(first_member_guid)
		assert_eq(s.size(), 1)
		assert_eq(s[0].guid, m[r.submembers_string][0]["guid"])
