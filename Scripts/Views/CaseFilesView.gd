class_name CaseFilesView
extends Node2D

@onready var casefiles_category_list:ItemList = %CasefileCategoryList
@onready var casefiles_item_list:ItemList = %CasefileItemList
@onready var casefiles_content_list:ItemList = %CasefileContentList
@onready var mysteries:MysteryResource 
var casefiles_array:Array
var casefiles_sub_dict:Dictionary


func _ready() -> void:
	casefiles_category_list.visible = false
	casefiles_item_list.visible = false
	casefiles_content_list.visible = false

func setup_from_controller(_m:MysteryResource):
	mysteries = _m

func on_start_dialog():
	casefiles_category_list.visible = true
	casefiles_item_list.visible = true
	casefiles_content_list.visible = true
	load_list()

func got_mystery_from_dialogic():
	load_list()

func load_list():
	casefiles_item_list.clear()
	casefiles_array.clear()
	var dm:Array = mysteries.get_discovered_mysteries()
	for m in dm:
		casefiles_item_list.add_item(m["description"])
		casefiles_array.append(m)
		var dc:Array = mysteries.get_clues_for_mystery(m["guid"])
		for c in dc:
			if casefiles_sub_dict.has(m["guid"]):
				casefiles_sub_dict[m["guid"]].append(c)
			else:
				casefiles_sub_dict[m["guid"]] = [c]
	


func _on_casefile_category_list_item_selected(index: int) -> void:
	pass # Replace with function body.


func _on_casefile_item_list_item_selected(index: int) -> void:
	pass # Replace with function body.
