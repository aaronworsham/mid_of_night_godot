class_name DiceManager
extends Node

var random = RandomNumberGenerator.new()
var set_roll = 0

func _ready() -> void:
	random.randomize()

func set_result(r:int):
	set_roll = r


func roll_d100() -> int:
	if(set_roll > 0):
		var x = set_roll
		set_roll = 0
		return x 
	else:
		return (randi() % 100)