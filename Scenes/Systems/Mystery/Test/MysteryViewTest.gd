class_name MysteryViewTest extends BaseRecordCatalogView

@onready var mystery_controller: MysteryControllerTest = %MysteryControllerTest

@onready var mysteries_list: VBoxContainer = %MysteriesVBox
@onready var clues_list: VBoxContainer = %CluesVBox
@onready var clue_detail_list: VBoxContainer = %DetailVBox
@onready var mystery_panel: Panel = %MysteryPanel

@onready var mystery_events: MysteryEventsTest = %MysteryEventsTest

func _ready() -> void:
    super.initialize(
        mystery_controller,
        mystery_panel,
        mysteries_list,
        clues_list,
        clue_detail_list
    )
    EventManager.event_test_close_all_panels.connect(_on_event_close_all_panels)
    EventManager.event_test_mystery_tab_clicked.connect(_on_event_mystery_clicked)


func _on_event_mystery_clicked() -> void:
    super.show_panel()

func _on_event_close_all_panels() -> void:
    super.hide_panel()

  