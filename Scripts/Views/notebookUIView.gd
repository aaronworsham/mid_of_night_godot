class_name NotebookUIView
extends CanvasLayer

@onready var notebook_list:ItemList = %NotebookList
var action:ActionableController
var topics:Dictionary
var topicKeys:Array

func _ready() -> void:
	EventManager.event_start_dialog.connect(set_actionable)

func set_actionable(act:ActionableController):
	action = act
	topics = act.actionable.notebook.topics
	topicKeys = topics.keys()
	for t in topicKeys:
		notebook_list.add_item(t)
		

func _on_notebook_list_item_clicked(_index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	print("button pressed")
	var topic = topics[topicKeys[_index]]
	print("Timeline: "+topic.timeline)
	print("Label: "+topic.label)
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return
	else:
		Dialogic.start(topic.timeline, topic.label)
	return
