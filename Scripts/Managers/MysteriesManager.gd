class_name MysteriesManager
extends Node

@export var mysteries:MysteryResource

func _ready() -> void:
	EventManager.event_mysteries_updated.connect(_on_mysteries_updated)
	Dialogic.signal_event.connect(_on_dialogic_signal)


func _on_mysteries_updated(m_key:String):
	print(m_key)
	match m_key:
		"Missing Girl": 
			print("Missing Girl Mystery")
			mysteries.set_mystery_as_discovered(m_key)

# Dialogic Signal scructure
# [Interact Type]/[Interact GUID]/[Case Type]/[Case GUID]
# Actor/vendor_actor_1/POD/the_village

func _on_dialogic_signal(_arg:String):
	var arg_array:Dictionary = MoDDialogicUtil.parse_signal_key(_arg)
	print ("MysteriesManager got Signal :" + arg_array["category_key"])
	
			