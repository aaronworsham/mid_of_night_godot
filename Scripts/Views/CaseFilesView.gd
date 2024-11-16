class_name CaseFilesView
extends Node2D

@onready var casefiles_list:ItemList = %CaseFileItemList
@onready var mysteries:MysteryResource 


func _ready() -> void:
	print("CaseFileReady")
	casefiles_list.visible = false

func setup_from_controller(_m:MysteryResource):
	mysteries = _m

func on_start_dialog():
	print("CaseFilesView: Got On Start Dialog from Detective Controller")
	casefiles_list.visible = true
	load_list()

func got_mystery_from_dialogic():
	print("CaseFilesView got mystery from Dialogic")
	load_list()

func load_list():
	casefiles_list.clear()
	var dm:Array = mysteries.get_discovered_mysteries()
	for m in dm:
		casefiles_list.add_item(m["description"])
	