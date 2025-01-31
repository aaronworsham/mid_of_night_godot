class_name CaseFilesView extends Node

@onready var casefiles_panel:Panel = %CasefilePanel


func _ready() -> void:
    casefiles_panel.visible = false


func _on_mysteries_pressed() -> void:

    EventManager.event_mystery_casefileui_populate_discovered_mysteries.emit()


func _on_toggle_casefile_panel_pressed() -> void:
    if casefiles_panel.visible:
        casefiles_panel.visible = false
    else:
        casefiles_panel.visible = true
