class_name CaseFilesView
extends Node2D

@onready var mysteries:MysteryResource
var actor_controller:ActorController

func _ready() -> void:
	EventManager.event_start_dialog.connect(_on_start_dialog)

func _on_start_dialog(ac:ActorController):
	print("CaseFilesView: Got Start Dialog Signal")
	actor_controller = ac
	self.visible = true

