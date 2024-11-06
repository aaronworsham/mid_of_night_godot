class_name ActorController
extends Node

@onready var querty_ui = get_node("/root/Main/UI/NotebookUI")
@onready var query_field = get_node("/root/Main/UI/NotebookUI").get_node("%QueryEdit")
@export var actor_resource: ActorResource
@export var notebook_resource: NotebookResource
@export var dialog_timeline: DialogicTimeline

func _ready() -> void:
	EventManager.event_start_dialog.connect(dialog_action)

func dialog_action(_act:ActorController) -> void:
	print("ActorController: Got signal from DetectiveController")
	querty_ui.visible = true