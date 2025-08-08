class_name OvertabViewTest extends Node

@onready var overtab_container: HBoxContainer = %OvertabContainer

func _ready() -> void:
    EventManager.event_test_overtab_clicked.connect(_on_overtab_view_test_overtab_clicked)  #TODO: remove this

func _on_overtab_view_test_overtab_clicked(overtab: OvertabModel) -> void:
    print("Overtab clicked: " + overtab.get_overtab_name() + " " + overtab.get_overtab_description()        )

func show_overtab() -> void:
    overtab_container.visible = true;

func hide_overtab() -> void:
    overtab_container.visible = false;



