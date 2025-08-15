class_name OvertablSystemEventsTest extends Node

@onready var dialog_btn: Button = %DialogBtn
@onready var mystery_btn: Button = %MysteriesBtn
@onready var research_btn: Button = %ResearchBtn
@onready var logbook_btn: Button = %LogbookBtn
@onready var overtab_controller: OvertabControllerTest = %OvertabControllerTest
@onready var overtab_view: OvertabViewTest = %OvertabViewTest

func _ready() -> void:
    dialog_btn.pressed.connect(_on_dialog_btn_pressed)
    mystery_btn.pressed.connect(_on_mystery_btn_pressed)
    research_btn.pressed.connect(_on_research_btn_pressed)
    logbook_btn.pressed.connect(_on_logbook_btn_pressed)

func _on_dialog_btn_pressed() -> void:
    EventManager.event_test_hide_all_actors.emit();
    EventManager.event_test_close_all_panels.emit();
    EventManager.event_test_dialog_clicked.emit();

func _on_mystery_btn_pressed() -> void:
    EventManager.event_test_hide_all_actors.emit();
    EventManager.event_test_close_all_panels.emit();
    EventManager.event_test_mystery_clicked.emit();

func _on_research_btn_pressed() -> void:
    EventManager.event_test_hide_all_actors.emit();
    EventManager.event_test_close_all_panels.emit();
    EventManager.event_test_research_clicked.emit();

func _on_logbook_btn_pressed() -> void:
    EventManager.event_test_hide_all_actors.emit();
    EventManager.event_test_close_all_panels.emit();
    EventManager.event_test_logbook_clicked.emit();
