class_name ActorControllerTest extends Node

@onready var actor_view: ActorViewTest = %ActorViewTest

func _ready() -> void:
	EventManager.event_test_interactable_actor_clicked.connect(_interactable_actor_clicked)

func _interactable_actor_clicked(actor: ActorModel) -> void:
	actor_view.hide_actors()