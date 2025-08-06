class_name InventoryView extends Node

@onready var casefile_items_vbox:VBoxContainer = %CasefileItemsVBox
@onready var content_display_lbox:RichTextLabel = %CasefileItemContentLBox
@onready var inventory_controller:InventoryController = %InventoryController

var _inventory:Array

func _ready() -> void:
    _inventory.clear()

func add_inventory_to_casefileui_item_vbox(i:ItemResource) -> void:
    var btn = UIUtility.create_button(i.get_item_name())
    btn.pressed.connect(self._button_pressed.bind(i))
    casefile_items_vbox.add_child(btn)


func _button_pressed(i:ItemResource)->void:
    var s:String = i.get_item_name()
    content_display_lbox.text = s