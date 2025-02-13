class_name CasefileView extends Node

@onready var casefiles_panel:Panel = %CasefilePanel
@onready var mystery_controller:MysteryController = %MysteryController
@onready var research_controller:ResearchController = %ResearchController


func _ready() -> void:
    casefiles_panel.visible = false


func _on_toggle_casefile_panel_pressed() -> void:
    if casefiles_panel.visible:
        casefiles_panel.visible = false
    else:
        casefiles_panel.visible = true


func _on_mystery_btn_pressed() -> void:
    mystery_controller.populate_casefile_ui_with_discovered_mysteries()


func _on_research_btn_pressed() -> void:
    research_controller.populate_casefile_ui_with_discovered_research()
