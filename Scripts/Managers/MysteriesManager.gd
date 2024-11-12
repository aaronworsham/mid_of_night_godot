class_name MysteriesManager
extends Node

@export var mysteries:MysteryResource

func _ready() -> void:
	EventManager.event_mysteries_updated.connect(_on_mysteries_updated)


func _on_mysteries_updated(m_key:String):
	print(m_key)
	match m_key:
		"Missing Girl": 
			mysteries.set_mystery_as_discovered(m_key)
			