extends CanvasLayer

@onready var notebook_list:ItemList = %NotebookList
@onready var notebook_topics:Array = ["Hello", "Information"]


func _ready() -> void:
	for t in notebook_topics:
		var button = Button.new()
		button.text = t
		notebook_list.add_child(button)


func _on_notebook_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	print("You pressed the "+notebook_topics[index]+"Button")
