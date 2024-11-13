class_name CaseFilesView
extends Node2D

@onready var casefiles_list:ItemList = %CaseFileItemList
@onready var mysteries:MysteryResource
var actor_controller:ActorController
var actor_resource:ActorResource
var notebook_resource:NotebookResource

func _ready() -> void:
	print("CaseFileReady")
	casefiles_list.visible = false
	EventManager.event_start_dialog.connect(_on_start_dialog)

func _on_start_dialog(ac:ActorController):
	print("CaseFilesView: Got Start Dialog Signal")
	actor_controller = ac
	actor_resource = ac.actor_resource
	notebook_resource = ac.notebook_resource
	casefiles_list.visible = true

func load_list():
	casefiles_list.clear()
	var objs:Array = mysteries.get_discovered_mysteries()
	for obj in objs:
		var key = obj.keys()[0]
		casefiles_list.add_item(key)