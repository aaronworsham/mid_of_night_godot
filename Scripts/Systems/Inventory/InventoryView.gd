class_name InventoryView extends Node

@onready var casefile_items_vbox:VBoxContainer = %CasefileItemsVBox
@onready var content_display_lbox:RichTextLabel = %CasefileItemContentLBox
@onready var inventory_controller:InventoryController = %InventoryController

var _inventory:Array

func _ready() -> void:
    _inventory.clear()


