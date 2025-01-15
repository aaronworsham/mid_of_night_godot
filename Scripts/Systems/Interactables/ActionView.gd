class_name ActionView extends Node2D
var actor:ActorModel


func save_actor(a:ActorModel):
    actor = a

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if  event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        print("Actor " + actor.get_actor_name() + " Clicked")
