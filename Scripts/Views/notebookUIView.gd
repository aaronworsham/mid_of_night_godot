class_name NotebookUIView
extends CanvasLayer

@onready var notebook_list:ItemList = %NotebookList
var action:ActionableController
var topics:Dictionary
var topicKeys:Array

func _ready() -> void:
	EventManager.event_start_dialog.connect(set_actionable)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func set_actionable(act:ActionableController):
	action = act
	topics = act.actionable.notebook.topics
	topicKeys = topics.keys()
	load_list()
		

func _on_notebook_list_item_clicked(_index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	print("button pressed")
	var topic = topics[topicKeys[_index]]
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		Dialogic.clear()
	Dialogic.start(
		topic[NotebookResource.topic_flags.TIMELINE], 
		topic[NotebookResource.topic_flags.LABEL]
	)
	return

func _on_dialogic_signal(_argument:String):
	print("got signal from Dialogic:"+_argument)
	topics[_argument][NotebookResource.topic_flags.DISCOVERED] = true
	load_list()

func load_list():
	notebook_list.clear()
	for t in topicKeys:
		if topics[t][NotebookResource.topic_flags.DISCOVERED]:
			notebook_list.add_item(t)