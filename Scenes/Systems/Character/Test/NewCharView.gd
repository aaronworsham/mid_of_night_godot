class_name NewCharView extends Node

@onready var new_char_controller:NewCharController = %NewCharController
@onready var new_char_panel:Panel = %NewCharPanel
@onready var back_to_options_btn:Button = %BackToOptionsBtn
@onready var new_char_skills:VBoxContainer = %NewCharSkills

func _ready() -> void:
    new_char_panel.visible = false
    back_to_options_btn.visible = false
    pass

func show_new_char_panel() -> void:
    new_char_panel.visible = true   
    back_to_options_btn.visible = true

func hide_new_char_panel() -> void:
    new_char_panel.visible = false
    back_to_options_btn.visible = false

func get_skills_container()->VBoxContainer:
    return new_char_skills