class_name ActorSceneTestUI extends Node

@onready var detective_left:CanvasLayer = %DetectiveLeft
@onready var actor_right:CanvasLayer= %ActorRight
@onready var actor_label:Label = %ActorLabel
@onready var actor_portrait:Sprite2D = %ActorPortrait

func _ready() -> void:
	print("Hiding UI")
	detective_left.visible = false
	actor_right.visible = false
	EventManager.event_interactable_actor_clicked.connect(_show_actor_dialog)

func _show_actor_dialog(actor:ActorModel):
	actor_label.text = actor.get_actor_name()
	print ("ACTUI: got actor:" + actor_label.text)
	actor_portrait.texture = load(actor.get_portrait_256_path())
	detective_left.visible = true
	actor_right.visible = true


