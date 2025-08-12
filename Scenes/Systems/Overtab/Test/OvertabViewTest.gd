class_name OvertabViewTest extends Node

@onready var logbook_btn: Button = %LogbookBtn
@onready var dialog_btn: Button = %DialogBtn
@onready var mystery_btn: Button = %MysteriesBtn
@onready var research_btn: Button = %ResearchBtn
@onready var overtab_container: HBoxContainer = %OvertabContainer

func _ready() -> void:
    pass
    
func _on_overtab_view_test_overtab_clicked(overtab: OvertabModel) -> void:
    print("Overtab clicked: " + overtab.get_overtab_name() + " " + overtab.get_overtab_description()        )

func show_overtab() -> void:
    overtab_container.visible = true;

func hide_overtab() -> void:
    overtab_container.visible = false;

func focus_on_logbook() -> void:
    logbook_btn.grab_focus()

func focus_on_dialog() -> void:
    dialog_btn.grab_focus()

