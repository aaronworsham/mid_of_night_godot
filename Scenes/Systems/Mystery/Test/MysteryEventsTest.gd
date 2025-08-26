class_name MysteryEventsTest extends BaseRecordCatalogEvents

@onready var mystery_close_btn: Button = %MysteryCloseBtn
@onready var mystery_view:MysteryViewTest = %MysteryViewTest
@onready var mystery_controller:MysteryControllerTest = %MysteryControllerTest


func _ready() -> void:
    super.initialize(mystery_view, mystery_controller, mystery_close_btn)
    pass

