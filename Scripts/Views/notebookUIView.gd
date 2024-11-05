class_name NotebookUIView
extends CanvasLayer

@onready var notebook_list:ItemList = %NotebookList
@onready var notebook_resource:NotebookResource = load("res://Resources/Notebooks/VendorNotebookResource.tres")
@onready var _notebook_topics = notebook_resource.notebook_topics.keys()
var action:ActionableController

func _ready() -> void:
	EventManager.event_start_dialog.connect(set_actionable)

func set_actionable(act:ActionableController):
	print("NotebookUIView: Got signal from DetectiveController")
	action = act

func _on_notebook_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	var topic = notebook_resource.notebook_topics[_notebook_topics[index]]
	var format_string = "You pressed the {key} Button, which has the Discovery set to {dis} and the Clicked set to {clk}"
	var actual_string = format_string.format(
		{
			"key":_notebook_topics[index],
			"dis":topic["discovered"], 
			"clk":topic["clicked"]
		}
	)

	print(actual_string)
