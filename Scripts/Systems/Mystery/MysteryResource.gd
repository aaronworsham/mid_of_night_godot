class_name MysteryResource
extends Resource

@export var json:JSON:
	set(value):
		json = value

#source of truth (direct from json)
var _mysteries_array:Array

#references to _mysteries_array
var _mysteries_dict:Dictionary
var _mysteries_guid_dict:Dictionary
var _clues_dict:Dictionary
var _clues_guid_dict:Dictionary
var _clues_array:Array
var _discovered_mysteries_array:Array
var _discovered_clues_array:Array


func on_load():
	_discovered_mysteries_array.clear()
	_discovered_clues_array.clear()
	_clues_array.clear()
	_clues_dict.clear()
	_clues_guid_dict.clear()
	_mysteries_dict.clear()
	_mysteries_guid_dict.clear()
	
	#source of truth
	_mysteries_array = json.data.data.duplicate(true)

	for m in _mysteries_array:
		_mysteries_dict[m["key"]] = m 
		_mysteries_guid_dict[m["guid"]] = m
		for c in m["clues"]:
			_clues_dict[c["key"]] = c
			_clues_guid_dict[c["guid"]] = c
			_clues_array.append(c)

		


# Mysteries

## Get Mysteries

func get_mysteries_as_dict()->Dictionary:
	return _mysteries_dict

func get_mysteries_as_array()->Array:
	return _mysteries_array

func get_mystery_keys()->Array:
	return _mysteries_dict.keys()

func get_mystery_by_key(key:String)->Dictionary:
	if _mysteries_dict.has(key):
		return _mysteries_dict[key]
	return {}

func get_mystery_by_guid(guid:String)->Dictionary:
	if _mysteries_guid_dict.has(guid):
		return _mysteries_guid_dict[guid]
	return {}

func get_discovered_mysteries()->Array:
	return _discovered_mysteries_array

func get_description(mystery:String)-> String:
	return _mysteries_dict[mystery]["description"]


## Has Mysteries

func has_mystery(key:String)->bool:
	return _mysteries_dict.has(key)

## Set mysteries

func set_mystery_as_discovered(m_key:String)->bool:
	_mysteries_dict[m_key]["state"]["discovered"] = true
	_discovered_mysteries_array.append(_mysteries_dict[m_key])
	return true

func set_mystery_as_discovered_by_guid(guid:String) -> bool:
	_mysteries_guid_dict[guid]["state"]["discovered"] = true
	_discovered_mysteries_array.append(_mysteries_guid_dict[guid])
	return true



## Is Mysteries

func is_mystery_discovered(m_key:String)->bool:
	return _mysteries_dict[m_key]["state"]["discovered"]




#Clues

##Get Clues

func get_clues_for_mystery(key:String)-> Array:
	if _mysteries_dict.has(key):
		return _mysteries_dict[key]["clues"]
	return []

func get_clue_by_key(key:String)-> Dictionary:
	if _clues_dict.has(key):
		return _clues_dict[key]
	return {}

func get_clue_by_guid(guid:String)-> Dictionary:
	if _clues_guid_dict.has(guid):
		return _clues_guid_dict[guid]
	return {}

func get_discovered_clues()-> Array:
	return _discovered_clues_array

## Is Clue


func is_clue_discovered(guid:String)-> bool:
	var clue:Dictionary = get_clue_by_key(guid)
	if clue:
		return clue["state"]["discovered"]
	return false

## Set Clue

func set_clue_as_discovered(guid:String):
	var clue:Dictionary = get_clue_by_key(guid)
	if clue:
		clue["state"]["discovered"] = true
		_discovered_clues_array.append(clue)
		
	



func save()-> Dictionary:
	print("MysteryResource Saving")
	return {}

func load():
	print("MysteryResource Loading")
