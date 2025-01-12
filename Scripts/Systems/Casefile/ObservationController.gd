class_name ObservationController extends Node

@onready var observation_view:ObservationView = get_node("/root/Main/UIOverlay/ObservationUI")

func _ready() -> void:
	EventManager.event_start_dialog.connect(_dialog_action)


func _dialog_action(_ac: ActorController):
	observation_view.on_start_dialog()
