class_name CaseFilesView
extends Node2D

@onready var casefiles_list:ItemList = %CaseFileItemList
@onready var casefiles_content_list:ItemList = %CaseFileContentList
@onready var mysteries:MysteryResource 
var casefiles_array:Array


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
	

func _on_case_file_item_list_item_selected(index: int) -> void:
	print("Item in Casefile selected: "+str(index))
	casefiles_content_list.add_item(casefiles_array[index]["content"])
