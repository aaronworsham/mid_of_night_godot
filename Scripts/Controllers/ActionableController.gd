class_name ActionableController
extends Node

@onready var querty_ui = get_node("/root/Main/UI/NotebookUI")
@onready var query_field = get_node("/root/Main/UI/NotebookUI").get_node("%QueryEdit")
@export var actionable: ActionableResource

func _ready() -> void:
	EventManager.event_start_dialog.connect(dialog_action)

func dialog_action(_act:ActionableController) -> void:
	print("ActionController: Got signal from DetectiveController")
	querty_ui.visible = true

