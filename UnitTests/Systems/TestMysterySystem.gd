class_name TestMysterySystem extends BaseTestDataSystem

var resource:MysterySystemResource = MysterySystemResource.new()
var mguid:String

func before_each():
    resource.on_load()
    data_system_resource = resource
    base_setup()
