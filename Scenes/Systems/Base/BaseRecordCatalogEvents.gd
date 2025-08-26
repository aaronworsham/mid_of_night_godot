class_name BaseRecordCatalogEvents extends Node

@onready var close_btn:Button = null
@onready var view:BaseRecordCatalogView = null
@onready var controller:BaseRecordCatalogController = null

func initialize(v:BaseRecordCatalogView, c: BaseRecordCatalogController, b:Button) -> void:
    close_btn = b
    view = v
    controller = c
    if close_btn:
        close_btn.pressed.connect(_on_close_btn_pressed)    

func _on_close_btn_pressed() -> void:
    EventManager.event_test_close_all_panels.emit()
    EventManager.event_test_show_all_actors.emit()
    view.hide_panel()