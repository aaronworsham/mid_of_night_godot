class_name OvertabControllerTest extends Node

@onready var overtab_view: OvertabViewTest = %OvertabViewTest

func _ready() -> void:
	EventManager.event_test_interactable_actor_clicked.connect(_interactable_actor_clicked)
	EventManager.event_test_dialog_closed.connect(_on_event_close_dialog)


func _interactable_actor_clicked(actor: ActorModel) -> void:
	overtab_view.focus_on_logbook()

func _on_event_close_dialog() -> void:
	pass
