class_name DialogView extends Node

@onready var dialog_list: VBoxContainer = %DialogVBox
@onready var dialog_ui:Node = get_node("/root/Main/UIOverlay/DialogUI")

func _ready() -> void:
	dialog_ui.visible = false

func show_dialog_ui():
	dialog_ui.visible = true

func update_dialog(copy:String):
	var dialog_container = RichTextLabel.new()
	dialog_container.text = copy
	dialog_container.fit_content = true
	dialog_container.bbcode_enabled = true
	dialog_list.add_child(dialog_container)

func clear_list(): 
	if dialog_list != null:
		for i in dialog_list.get_children():
			i.queue_free()
