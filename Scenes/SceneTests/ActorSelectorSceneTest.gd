class_name ActorSelectorSceneTest extends Node2D

@onready var back_to_main_btn:Button = %BackToMainBtn

func _ready() -> void:
	back_to_main_btn.pressed.connect(_on_back_to_main_btn_pressed)
	pass

func _on_back_to_main_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Tests/SceneSelectorTest.tscn")
	print("Back to Main Button Pressed")
