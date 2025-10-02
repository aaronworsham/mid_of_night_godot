class_name TestResearchSystem extends BaseTestDataSystem

var resource:ResearchSystemResource = ResearchSystemResource.new()
var mguid:String

func before_each():
    resource.on_load()
    data_system_resource = resource
    base_setup()