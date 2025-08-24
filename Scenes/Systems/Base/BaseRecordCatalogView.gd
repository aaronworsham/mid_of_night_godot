extends Node

# BaseRecordCatalogView.gd
# Reusable base view for displaying cataloged records (e.g., mysteries, clues, research topics)
# Follows MVC pattern: View class for UI presentation and user interaction

class_name BaseRecordCatalogView

@onready var controller: BaseRecordCatalogController = null
@onready var records_list: VBoxContainer = null
@onready var subrecords_list: VBoxContainer = null
@onready var close_btn:Button = null
@onready var panel:Panel = null

func _ready() -> void:
    pass

func initialize(
    c: BaseRecordCatalogController, 
    b: Button, 
    p: Panel,
    rl: VBoxContainer,
    srl: VBoxContainer
    ) -> void:
    controller = c  
    close_btn = b
    panel = p
    subrecords_list = srl
    records_list = rl
    if close_btn != null && panel != null:
        close_btn.pressed.connect(hide_panel)

func load_record_list(records:Array) -> void:
    for r in records:
        var btn:Button = UIUtility.create_button(r["label"])
        btn.pressed.connect(_on_record_button_pressed.bind(r))
        records_list.add_child(btn)  

func load_subrecord_list(subrecords:Array) -> void:
    for sr in subrecords:
        var btn:Button = UIUtility.create_button(sr["label"])
        btn.pressed.connect(_on_record_button_pressed.bind(sr))
        subrecords_list.add_child(btn)

func _on_record_button_pressed(record:Dictionary) -> void:
    print("Record pressed: " + record["label"])
    controller.load_discovered_sub_records(record["guid"])

func clear_record_list() -> void:
    if records_list != null:
        for i in records_list.get_children():
            i.queue_free()  

func clear_subrecord_list() -> void:
    if subrecords_list != null:
        for i in subrecords_list.get_children():
            i.queue_free()

func show_panel() -> void:
    panel.visible = true    

func hide_panel() -> void:
    panel.visible = false