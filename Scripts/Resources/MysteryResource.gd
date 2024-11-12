class_name MysteryResource
extends Resource

@export var json:JSON

func set_json(_json:JSON):
	json = _json

func get_mysteries()->Array:
	var array = []
	for m in json.data:
		array.append(m)
	return array

func get_description(mystery:String)-> String:
	return json.data[mystery]["description"]

func get_clues(mystery:String)-> Array:
	return json.data[mystery]["clues"]

func get_clue_name(m_key:String, c_key:String)->String:
	return json.data[m_key]["clues"][c_key]["static"]["name"]