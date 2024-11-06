class_name NotebookView
extends CanvasLayer

@onready var notebook_list:ItemList = %NotebookList
var actor_controller:ActorController
var actor_resource:ActorResource
var notebook_resource:NotebookResource


func _ready() -> void:
	EventManager.event_start_dialog.connect(_dialog_action)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _dialog_action(ac:ActorController):
	print("NotebookViewUI: Got signal from DetectiveController")
	actor_controller = ac
	actor_resource = ac.actor_resource
	notebook_resource = ac.notebook_resource
	load_list()
		

func _on_notebook_list_item_clicked(_index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	print("button pressed")
	var topicKey = notebook_resource.get_topic_key_from_index(_index)
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		Dialogic.clear()
	Dialogic.start(
		notebook_resource.get_timeline(topicKey), 
		notebook_resource.get_label(topicKey), 
	)
	return

func _on_dialogic_signal(_argument:String):
	print("got signal from Dialogic:"+_argument)
	var arg_array = _argument.split("/", true, 0)
	if notebook_resource.set_discovered(arg_array[2]):
		load_list()
	else:
		print("Invalid key: "+arg_array[2] )


func load_list():
	notebook_list.clear()
	for t in notebook_resource.topics.keys():
		if notebook_resource.is_discovered(t):
			notebook_list.add_item(t)