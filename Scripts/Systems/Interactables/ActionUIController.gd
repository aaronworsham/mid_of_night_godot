class_name ActionUIController extends Node

@onready var action_view:ActionView = get_node("/root/Main/UIOverlay/ActionUI")

func _ready() -> void:
	EventManager.event_start_dialog.connect(_dialog_action)

func _dialog_action(_ac: ActorController):
	action_view.on_dialog_action()
