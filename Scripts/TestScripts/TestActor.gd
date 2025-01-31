extends StaticBody2D


func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        print("mouse")
