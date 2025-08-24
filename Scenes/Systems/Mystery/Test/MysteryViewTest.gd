class_name MysteryViewTest extends Node
@onready var mysteries_list: VBoxContainer = %MysteriesVBox
@onready var Clues_list: VBoxContainer = %CluesVBox
@onready var detail_list: VBoxContainer = %DetailVBox

@onready var mystery_panel: Panel = %MysteryPanel
@onready var mystery_close_btn: Button = %MysteryCloseBtn

@onready var mystery_controller:MysteryControllerTest = %MysteryControllerTest
@onready var mystery_events: MysteryEventsTest = %MysteryEventsTest

var _mysteries:Array = []
var _Clues:Array = []

func _ready() -> void:
    _mysteries.clear()
    _Clues.clear()
    mystery_panel.visible = false
    mystery_close_btn.pressed.connect(_on_mystery_close_btn_pressed)    
    EventManager.event_test_mystery_clicked.connect(_on_event_mystery_clicked)

func _on_event_mystery_clicked() -> void:
    mystery_panel.visible = true

func load_mystery_list(mysteries:Array) -> void:
    _mysteries = mysteries
    clear_mystery_list()
    for m in _mysteries:
        var btn:Button = UIUtility.create_button(m["label"])
        btn.pressed.connect(_on_mystery_button_pressed.bind(m))
        mysteries_list.add_child(btn)   

func _on_mystery_button_pressed(mystery:Dictionary) -> void:
    clear_Clue_list()
    _Clues = mystery["clues"]
    load_Clue_list()       

func load_Clue_list() -> void:
    clear_Clue_list()
    for t in _Clues:
        var btn:Button = UIUtility.create_button(t["label"])            
        btn.pressed.connect(_on_Clue_button_pressed.bind(t))
        Clues_list.add_child(btn)  

func _on_Clue_button_pressed(Clue:Dictionary) -> void:
    clear_content_list()
    var content:RichTextLabel = UIUtility.create_rich_copy_label(Clue["description"])
    detail_list.add_child(content) 

func clear_mystery_list() -> void:
    if mysteries_list != null:
        for i in mysteries_list.get_children():
            i.queue_free()  

func clear_Clue_list() -> void:
    if Clues_list != null:
        for i in Clues_list.get_children():
            i.queue_free()      

func clear_content_list() -> void:
    if detail_list != null:
        for i in detail_list.get_children():
            i.queue_free() 
        clear_Clue_list()
        clear_mystery_list()
    

func _on_mystery_close_btn_pressed() -> void:
    EventManager.event_test_close_all_panels.emit()
    EventManager.event_test_show_all_actors.emit()  