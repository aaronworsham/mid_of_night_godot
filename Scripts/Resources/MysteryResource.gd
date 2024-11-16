class_name MysteryResource
extends Resource

@export var json:JSON:
	set(value):
		json = value
var _mysteries_dict:Dictionary
var _discovered_mysteries_array:Array
var _discovered_clues_array:Array


func on_load():
	_mysteries_dict = json.data.duplicate(true)
	_discovered_mysteries_array.clear()
	_discovered_clues_array.clear()
	for m in _mysteries_dict:
		if _mysteries_dict[m]["state"]["discovered"] == true:
			_discovered_mysteries_array.append(_mysteries_dict[m])
		for c in _mysteries_dict[m]["clues"]:
			if c["state"]["discovered"] == true:
				_discovered_clues_array.append(c)

func get_mysteries_as_dict()->Dictionary:
	return _mysteries_dict

func get_mysteries_as_array()->Array:
	var array:Array
	for m in _mysteries_dict:
		array.append(_mysteries_dict[m])
	return array

func get_mystery_by_guid(guid:String):
	if _mysteries_dict[guid]:
		return _mysteries_dict[guid]
	return null

func get_mystery_keys()->Array:
	return _mysteries_dict.keys()

func get_mystery(key:String)-> bool:
	return _mysteries_dict.find_key(key)

func has_mystery(key:String)->bool:
	return _mysteries_dict.has(key)

func get_discovered_mysteries()->Array:
	return _discovered_mysteries_array

func get_description(mystery:String)-> String:
	return _mysteries_dict[mystery]["description"]

func get_mystery_from_dialogic_signal_key(key:String):
	for m_key in _mysteries_dict:
		if _mysteries_dict[m_key]["dialogic_signal_key"] == key:
			return _mysteries_dict[m_key]
	return null


func get_clues_for_mystery(key:String)-> Array:
	return _mysteries_dict[key]["clues"]

func get_clue_from_dialogic_signal_key(key:String):
	var signal_dict:Dictionary = MoDDialogicUtil.parse_signal_key(key)
	var clues:Array = get_clues_for_mystery(signal_dict["casefile_key"])
	for c in clues:
		if c["key"] == signal_dict["sub_key"]:
			return c
	return null

func get_clue_by_guid(guid:String):
	for m in _mysteries_dict:
		for c in _mysteries_dict[m]["clues"]:
			if c["guid"] == guid:
				return c
	return null	

func is_clue_discovered(guid:String)-> bool:
	var clue:Dictionary = get_clue_by_guid(guid)
	if clue:
		return clue["state"]["discovered"]
	return false

func get_discovered_clues()-> Array:
	return _discovered_clues_array

func set_clue_as_discovered(guid:String):
	var clue:Dictionary = get_clue_by_guid(guid)
	if clue:
		clue["state"]["discovered"] = true
		_discovered_clues_array.append(clue)
		
	

func set_mystery_as_discovered(m_key:String)->bool:
	_mysteries_dict[m_key]["state"]["discovered"] = true
	_discovered_mysteries_array.append(_mysteries_dict[m_key])
	return true

func is_mystery_discovered(m_key:String)->bool:
	return _mysteries_dict[m_key]["state"]["discovered"]

func save()-> Dictionary:
	print("MysteryResource Saving")
	return {}

func load():
	print("MysteryResource Loading")
