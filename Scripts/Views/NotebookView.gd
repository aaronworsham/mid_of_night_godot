class_name NotebookView
extends Node2D

@onready var notebook_list:ItemList = %NotebookList
@onready var querty_ui:TextEdit = %QueryEdit
var actor_controller:ActorController
var actor_resource:ActorResource
var notebook_resource:NotebookResource


func _ready() -> void:
	print("NotebookView Ready")
	notebook_list.visible = false
	querty_ui.visible = false
	EventManager.event_start_dialog.connect(_dialog_action)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _dialog_action(ac:ActorController):
	print("NotebookViewUI: Got signal from DetectiveController")
	actor_controller = ac
	actor_resource = ac.actor_resource
	notebook_resource = ac.notebook_resource
	notebook_list.visible = true
	querty_ui.visible = true
	load_list()
		

func _on_notebook_list_item_clicked(_index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	print("button pressed")
	
	#Set the Clicked value
	notebook_resource.set_clicked_by_index(_index)

	#tupal to get [timeline, lable]
	var tupal = notebook_resource.get_dialogic_tupal(_index)

	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		Dialogic.clear()

	Dialogic.start(tupal[0],tupal[1])
	
	return

# Dialogic Signal scructure
# [Interact Type]/[Interact GUID]/[Case Type]/[Case GUID]
# Actor/vendor_actor_1/POD/the_village

func _on_dialogic_signal(_argument:String):
	print("Notebook Manager got signal from Dialogic:"+_argument)
	var arg_array = _argument.split("/", true, 0)
	
	if notebook_resource.set_discovered(arg_array[3]):
		load_list()
	else:
		print("Invalid key: "+arg_array[3] )


func load_list():
	notebook_list.clear()
	var objs:Array = notebook_resource.get_discovered_objects()
	for obj in objs:
		var key = obj.keys()[0]
		var label:String 
		if obj[key]["dynamic"]["clicked"] == true:
			label = key + " (clicked)"
		else:
			label = key
		notebook_list.add_item(label)
