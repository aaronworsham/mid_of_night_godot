class_name CasefilesController extends Node

@onready var mystery_resource:MysteryResource = load("res://Resources/CaseFiles/Mysteries/Mysteries.tres")
@onready var casefiles_view:CaseFilesView = get_node("/root/Main/UIOverlay/CasefilesUI")

func _ready() -> void:
	EventManager.event_start_dialog.connect(_on_start_dialog)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	casefiles_view.setup_from_controller(mystery_resource)
	mystery_resource.on_load()


func _on_start_dialog(_ac:ActorController):
	print("CasefilesController: _on_start_dialog")
	casefiles_view.on_start_dialog()
	

func _on_dialogic_signal(_argument:String):
	print("CasefilesController: _on_dialogic_signal")
	var signal_args:Dictionary = MoDDialogicUtil.parse_signal_key(_argument)
	match signal_args["category"]:
		"Mystery":
			print("CasefileController: Got a Mystery from Dialogic")
			mystery_resource.set_mystery_as_discovered(signal_args["category_key"])
			casefiles_view.got_mystery_from_dialogic()

func save()->Dictionary:
	print("CaseFilesController: Saving")
	mystery_resource.save()
	return {}
