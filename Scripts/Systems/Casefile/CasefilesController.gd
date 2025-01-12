class_name CasefilesController extends Node

@onready var mystery_resource:MysteryResource = load("res://Resources/CaseFiles/Mysteries/Mysteries.tres")
@onready var casefiles_view:CaseFilesView = get_node("/root/Main/UIOverlay/CasefilesUI")

func _ready() -> void:
	EventManager.event_start_dialog.connect(_on_start_dialog)
	EventManager.event_casefile_updated.connect(_on_casefile_updated)
	casefiles_view.setup_from_controller(mystery_resource)
	mystery_resource.on_load()


func _on_start_dialog(_ac:ActorController):
	casefiles_view.on_start_dialog()

func _on_casefile_updated(data:Dictionary):
	pass
	


func save()->Dictionary:
	print("CaseFilesController: Saving")
	mystery_resource.save()
	return {}
