extends Node2D

var second_chapter = load("res://Scenes/Chapters/secondary_chapter.tscn")

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("new_scene"):
		change_scene()

func change_scene():
	get_tree().change_scene_to_packed(second_chapter)
