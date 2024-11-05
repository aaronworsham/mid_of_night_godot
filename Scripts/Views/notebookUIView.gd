extends CanvasLayer

@onready var notebook_list:ItemList = %NotebookList
@onready var notebook_topics:Array = ["Hello", "Information"]


func _ready() -> void:
	for t in notebook_topics:
		notebook_list.add_item(t)


func _on_notebook_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	print("You pressed the "+notebook_topics[index]+"Button")
