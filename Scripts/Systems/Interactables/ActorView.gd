class_name ActionView extends Node2D
var actor:ActorModel


func save_actor(a:ActorModel):
    actor = a

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        EventManager.event_interactable_actor_clicked.emit(actor)
