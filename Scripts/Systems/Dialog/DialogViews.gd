class_name DialogView extends Node

@onready var dialog_list: VBoxContainer = %DialogVBox
@onready var notebook_list: VBoxContainer = %NotebookVBox
@onready var dialog_ui:Node = get_node("/root/Main/UI/DialogUI")

var _topics:Array

func _ready() -> void:
    _topics.clear()
    dialog_ui.visible = false

func show_dialog_ui():
    print("Show Dialog UI")
    dialog_ui.visible = true

func update_dialog(copy:String):
    dialog_list.add_child(create_vbox_child(copy))

func create_vbox_child(copy:String) -> RichTextLabel:
    var label = RichTextLabel.new()
    label.text = copy
    label.fit_content = true
    label.bbcode_enabled = true
    return label

func clear_list(): 
    if dialog_list != null:
        for i in dialog_list.get_children():
            i.queue_free()

func add_topic(t:String):
    _topics.append(t)

func load_notebook_list():
    for t in _topics:
        notebook_list.add_child(create_vbox_child(t))
