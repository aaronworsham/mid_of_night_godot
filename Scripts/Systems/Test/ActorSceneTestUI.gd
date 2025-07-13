class_name ActorSceneTestUI extends Node

@onready var detective_left:CanvasLayer = %DetectiveLeft
@onready var actor_right:CanvasLayer= %ActorRight

func _ready() -> void:
	print("Hiding UI")
	detective_left.hide()
	actor_right.hide()
	EventManager.event_test_show_actor_dialog.connect(_show_actor_dialog)

func _show_actor_dialog(actor:ActorModel):
	detective_left.show()
	actor_right.show()
	print ("got actor:" + actor.get_actor_name())


