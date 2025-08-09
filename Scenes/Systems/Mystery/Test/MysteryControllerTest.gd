class_name MysteryControllerTest extends Node

@onready var mystery_view: MysteryViewTest = %MysteryViewTest
@onready var mystery_panel: Panel = %MysteryPanel

func _ready() -> void:
	mystery_panel.visible = false
	EventManager.event_test_mystery_clicked.connect(_on_event_mystery_clicked)

func _on_event_close_dialog() -> void:
	pass

func _on_event_mystery_clicked(mystery: MysteryModel) -> void:
	mystery_panel.visible = true
