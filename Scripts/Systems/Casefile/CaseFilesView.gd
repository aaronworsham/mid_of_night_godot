class_name CaseFilesView
extends Control

@onready var casefiles_panel:Panel = %CaseFilePanel


func _ready() -> void:
    casefiles_panel.visible = false


func _on_open_casefile_btn_pressed() -> void:
    if casefiles_panel.visible:
        casefiles_panel.visible = false
    else:
        casefiles_panel.visible = true
