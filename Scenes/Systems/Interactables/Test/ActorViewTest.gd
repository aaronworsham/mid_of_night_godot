class_name ActorViewTest extends Node2D
var actor:ActorModel
var target_range:int = 30
var clickable:bool = true

@onready var actors_container:Node = %Actors

func _ready() -> void:
	EventManager.event_test_interactable_actor_clicked.connect(hide_actor)
	EventManager.event_test_dialog_closed.connect(show_actor)

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

func show_actor() -> void:
	visible = true;

func hide_actor(a:ActorModel) -> void:
	visible = false;
