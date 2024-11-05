class_name NotebookUIView
extends CanvasLayer

@onready var notebook_list:ItemList = %NotebookList
var action:ActionableController
var topics:Dictionary

func _ready() -> void:
	EventManager.event_start_dialog.connect(set_actionable)

func set_actionable(act:ActionableController):
	action = act
	topics = act.actionable.notebook.topics
	for t in topics.keys():
		notebook_list.add_item(t)

func _on_notebook_list_item_clicked(_index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	print("button pressed")
