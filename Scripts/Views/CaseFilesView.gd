class_name CaseFilesView
extends Node2D

@onready var casefiles_list:ItemList = %CaseFileItemList
@onready var mysteries:MysteryResource = load("res://Resources/CaseFiles/Mysteries/Mysteries.tres")
var actor_controller:ActorController
var actor_resource:ActorResource
var notebook_resource:NotebookResource

func _ready() -> void:
	print("CaseFileReady")
	casefiles_list.visible = false
	EventManager.event_start_dialog.connect(_on_start_dialog)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_start_dialog(ac:ActorController):
	print("CaseFilesView: Got On Start Dialog from Detective Controller")
	actor_controller = ac
	actor_resource = ac.actor_resource
	notebook_resource = ac.notebook_resource
	casefiles_list.visible = true
	load_list()

func _on_dialogic_signal(_argument:String):
	print("CaseFilesView got On Dialogic Signal: "+_argument)
	var arg_array = _argument.split("/", true, 0)
	if mysteries.has_mystery(arg_array[3]):
		mysteries.set_mystery_as_discovered(arg_array[3])
	load_list()

func load_list():
	casefiles_list.clear()
	var objs:Array = mysteries.get_discovered_mysteries()
	for m in objs:
		casefiles_list.add_item(m["description"])
	