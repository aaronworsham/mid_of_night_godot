class_name ActorViewTest extends Node2D
var actor:ActorModel
var target_range:int = 30
var clickable:bool = true


func save_actor(a:ActorModel):
	actor = a

	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				var mouse_pos:Vector2 = get_local_mouse_position()
				var target_pos:Vector2 = Vector2.ZERO
				if (mouse_pos.distance_to(target_pos) < 30):
					print("clicked actor: "+ actor.get_actor_name())
					EventManager.event_test_interactable_actor_clicked.emit(actor)
