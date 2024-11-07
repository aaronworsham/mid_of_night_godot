extends Node

var _toggle_visible:bool = false
@onready var button_list:ItemList = %ButtonList
@onready var toast_message:Label = %ToastMessage


func _ready() -> void:
	EventManager.event_testing_ui.connect(_on_testing_ui)

func _on_item_list_item_selected(index:int) -> void:
	var button_text = button_list.get_item_text(index)
	match button_text:
		"Save":
			EventManager.emit_save_game()
			toast_message.text = "Saving Game"
		"Load":
			EventManager.emit_load_game()
			toast_message.text = "Loading Game"
		"Quit":
			get_tree().quit()


func _on_testing_ui():
	if _toggle_visible == false:
		self.visible = true
		_toggle_visible = true
	else:
		self.visible = false
		_toggle_visible = false
