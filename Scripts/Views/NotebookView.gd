class_name NotebookView
extends Node2D

@onready var notebook_list:ItemList = %NotebookList
@onready var querty_ui:TextEdit = %QueryEdit
var actor_controller:ActorController
var actor_resource:ActorResource
var notebook_resource:NotebookResource
var thread_resource:ThreadResource
var notebook_topics:Array


func _ready() -> void:
	print("NotebookView Ready")
	notebook_list.visible = false
	querty_ui.visible = false


func dialog_action(ac:ActorController):
	print("NotebookViewUI: Got On Start Dialog from DetectiveController")
	actor_controller = ac
	actor_resource = ac.actor_resource
	notebook_resource = ac.notebook_resource
	notebook_resource.on_load()
	thread_resource = ac.thread_resource
	thread_resource.on_load()
	notebook_list.visible = true
	querty_ui.visible = true
	load_list()


func _on_notebook_list_item_clicked(_index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	print(notebook_topics[_index])
	EventManager.emit_event_notebook_clicked(notebook_topics[_index])


# Dialogic Signal scructure
# [Interact Type]/[Interact GUID]/[Case Type]/[Case GUID]
# Actor/vendor_actor_1/POD/the_village

func on_dialogic_signal(_argument:String):
	print("NotebookView got signal from Dialogic: "+_argument)
	var tmpD:Dictionary = MoDDialogicUtil.parse_signal_key(_argument)
	notebook_topics.append(tmpD)
	load_list()

func load_list():
	notebook_list.clear()
	for topic in notebook_topics:
		notebook_list.add_item(topic["label"])
