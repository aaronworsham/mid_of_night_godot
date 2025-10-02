class_name SceneSelectorTest extends Node

@onready var actor_selector_scene_btn:Button = %ActorSelectorSceneBtn
@onready var char_creation_scene_btn:Button = %CharCreationSceneBtn


func _ready() -> void:
    actor_selector_scene_btn.pressed.connect(_on_actor_selector_scene_btn_pressed)
    char_creation_scene_btn.pressed.connect(_on_character_creation_scene_btn_pressed)
    pass

func _on_actor_selector_scene_btn_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/Tests/ActorSelectorSceneTest.tscn")
    print("Actor Selector Scene Button Pressed")

func _on_character_creation_scene_btn_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/Tests/CharacterCreationSceneTest.tscn")
    print("Character Creation Scene Button Pressed")