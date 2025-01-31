class_name DialogView extends Node

@onready var dialog_list: VBoxContainer = %TopicsVBox
@onready var notebook_list: VBoxContainer = %DialogVBox
@onready var dialog_ui:Node = %DialogPanel
@onready var dialog_controller:DialogController = %DialogController

var _topics:Array

func _ready() -> void:
    _topics.clear()
    dialog_ui.visible = false

func show_dialog_ui():
    print("Show Dialog UI")
    dialog_ui.visible = true

func update_dialog(copy:String):
    dialog_list.add_child(UIUtility.create_rich_copy_label((copy)))

func clear_topics():
    _topics.clear()

func clear_dialog_list(): 
    if dialog_list != null:
        for i in dialog_list.get_children():
            i.queue_free()

func clear_notebook_list(): 
    if notebook_list != null:
        for i in notebook_list.get_children():
            i.queue_free()

func add_topic(t:Dictionary):
    _topics.append(t)

func load_notebook_list():
    clear_notebook_list()
    for t in _topics:
        var button:Button = UIUtility.create_button(t["label"])
        button.pressed.connect(self._button_pressed.bind(t["guid"]))
        notebook_list.add_child(button)

func _button_pressed(guid:String):
    print("Button Pressed: " + guid)
    dialog_controller.set_current_thread(guid)
