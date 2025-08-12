class_name DialogViewTest extends Node

@onready var topic_list: VBoxContainer = %TopicsVBox
@onready var dialog_list: VBoxContainer = %DialogVBox
@onready var dialog_ui:Node = %DialogPanel
@onready var dialog_controller:DialogControllerTest = %DialogControllerTest
@onready var detective_left:CanvasLayer = %DetectiveLeft
@onready var actor_right:CanvasLayer= %ActorRight
@onready var actor_label:Label = %ActorLabel
@onready var actor_portrait:Sprite2D = %ActorPortrait


var _topics:Array

func _ready() -> void:
	_topics.clear()
	dialog_ui.visible = false
	detective_left.visible = false
	actor_right.visible = false
	EventManager.event_test_interactable_actor_clicked.connect(show_dialog_ui)

func show_dialog_ui(actor:ActorModel):
	actor_label.text = actor.get_actor_name()
	print ("ACTUI: got actor:" + actor_label.text)
	actor_portrait.texture = load(actor.get_portrait_256_path())
	detective_left.visible = true
	actor_right.visible = true
	dialog_ui.visible = true

	#load_topic_list()

func hide_dialog_ui():
	clear_topic_list()
	clear_dialog_list()
	clear_topics()
	detective_left.visible = false
	actor_right.visible = false
	dialog_ui.visible = false


func update_dialog(copy:String):
	dialog_list.add_child(UIUtility.create_rich_copy_label((copy)))

func clear_topics():
	_topics.clear()

func clear_topic_list():
	if topic_list != null:
		for i in topic_list.get_children():
			i.queue_free()

func clear_dialog_list(): 
	if dialog_list != null:
		for i in dialog_list.get_children():
			i.queue_free()

func add_topic(t:Dictionary):
	_topics.append(t)

func load_topic_list():
	clear_topic_list()
	for t in _topics:
		var button:Button = UIUtility.create_button(t["label"])
		button.pressed.connect(self._button_pressed.bind(t["guid"]))
		topic_list.add_child(button)

func _button_pressed(guid:String):
	print("Button Pressed: " + guid)
	dialog_controller.set_current_thread(guid)
