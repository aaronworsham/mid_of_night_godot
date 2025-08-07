class_name OvertabViewTest extends Control


func _ready() -> void:
    EventManager.event_test_overtab_clicked.connect(_on_overtab_view_test_overtab_clicked)  #TODO: remove this

func _on_overtab_view_test_overtab_clicked(overtab: OvertabModel) -> void:
    print("Overtab clicked: " + overtab.get_overtab_name() + " " + overtab.get_overtab_description()        )



