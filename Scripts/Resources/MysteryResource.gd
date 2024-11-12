class_name MysteryResource
extends Resource

@export var json:JSON

func set_json(_json:JSON):
	json = _json

func get_mysteries()->Dictionary:
	return json.data

func get_description(mystery:String)-> String:
	return json.data[mystery]["description"]

func get_clues(mystery:String)-> Dictionary:
	return json.data[mystery]["clues"]

func get_clue_name(m_key:String, c_key:String)->String:
	return json.data[m_key]["clues"][c_key]["static"]["name"]

func set_mystery_as_discovered(m_key:String)->bool:
	json.data[m_key]["dynamic"]["discovered"] = true
	return true

func is_mystery_discovered(m_key:String)->bool:
	return json.data[m_key]["dynamic"]["discovered"]