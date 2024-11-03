class_name MysteriesManager
extends Node

@export var girl_mystery:bool

func _ready() -> void:
	EventManager.event_mysteries_updated.connect(_on_mysteries_updated)


func _on_mysteries_updated(mystery:String):
	print(mystery)
	match mystery:
		"Missing Girl": 
			girl_mystery = true
			