class_name CharacterCreationSceneTest extends Node

@onready var new_char_button:Button = %NewCharBtn
@onready var back_to_main_btn:Button = %BackToMainBtn
@onready var char_options_panel:Panel = %CharOptionsPanel  

func _ready() -> void:
    new_char_button.pressed.connect(_on_new_char_button_pressed)
    back_to_main_btn.pressed.connect(_on_back_to_main_btn_pressed)
    EventManager.event_test_back_to_options_button.connect(_on_event_test_back_to_options_button)   
    pass    

func _on_new_char_button_pressed() -> void:
    EventManager.event_test_new_character_button.emit()
    print("New Character Button Pressed")
    char_options_panel.visible = false

func _on_back_to_main_btn_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/SceneTests/SceneSelectorTest.tscn")
    print("Back to Main Button Pressed")

func _on_event_test_back_to_options_button() -> void:
    char_options_panel.visible = true
    print("Back to Options Event Received")