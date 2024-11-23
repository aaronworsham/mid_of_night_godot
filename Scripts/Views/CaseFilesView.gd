class_name CaseFilesView
extends Node2D

@onready var casefiles_list:ItemList = %CaseFileItemList
@onready var casefiles_content_list:ItemList = %CaseFileContentList
@onready var mysteries:MysteryResource 
var casefiles_array:Array
var casefiles_sub_dict:Dictionary


func _ready() -> void:
	print("CaseFileReady")
	casefiles_list.visible = false
	casefiles_content_list.visible = false

func setup_from_controller(_m:MysteryResource):
	mysteries = _m

func on_start_dialog():
	print("CaseFilesView: Got On Start Dialog from Detective Controller")
	casefiles_list.visible = true
	casefiles_content_list.visible = true
	load_list()

func got_mystery_from_dialogic():
	print("CaseFilesView got mystery from Dialogic")
	load_list()

func load_list():
	casefiles_list.clear()
	casefiles_array.clear()
	var dm:Array = mysteries.get_discovered_mysteries()
	for m in dm:
		casefiles_list.add_item(m["description"])
		casefiles_array.append(m)
		var dc:Array = mysteries.get_clues_for_mystery(m["guid"])
		for c in dc:
			if casefiles_sub_dict.has(m["guid"]):
				casefiles_sub_dict[m["guid"]].append(c)
			else:
				casefiles_sub_dict[m["guid"]] = [c]
	

func _on_case_file_item_list_item_selected(index: int) -> void:
	var casefile = casefiles_array[index]
	casefiles_content_list.add_item(casefile["description"])
	if casefiles_sub_dict.has(casefile["guid"]):
		for c in casefiles_sub_dict[casefile["guid"]]:
			casefiles_content_list.add_item(c["description"])
