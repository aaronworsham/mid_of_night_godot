class_name TestDialogSystem extends BaseTestDataSystem

var resource:DialogSystemResource = DialogSystemResource.new()
var mguid:String

func before_each():
    resource.on_load()
    data_system_resource = resource
    base_setup()
