class_name NotebookResource
extends Resource

@export var json:JSON:
	set(value):
		json = value
var _threads_dict:Dictionary
var _discovered_threads_array:Array


func on_load():
	_threads_dict = json.data.duplicate(true)
	_discovered_threads_array.clear()	
	for t in _threads_dict:
		if _threads_dict[t]["state"]["discovered"] == true:
			_discovered_threads_array.append(_threads_dict[t])

func get_threads_as_dict()-> Dictionary:
	return _threads_dict


# func get_keys()->Array:
# 	return json.data.keys()
	

# func get_discovered_objects()-> Array:
# 	var a = []
# 	for t in json.data:
# 		if json.data[t]["dynamic"]["discovered"] == true:
# 			a.append({t:json.data[t]})
# 	return a

# func get_clicked_by_key(key:String)->bool:
# 	return json.data[key]["dynamic"]["clicked"]

# func get_dialogic_tupal(_index:int)->Array:
# 	var key = get_topic_key_from_index(_index)
# 	var array = [
# 		get_timeline(key),
# 		get_label(key)
# 	]
# 	return array

# func set_dynamic_data(key1:String, key2:String, value)->void:
# 	json.data[key1]["dynamic"][key2] = value

# func is_discovered(key:String)-> bool:
# 	return json.data[key]["dynamic"]["discovered"]

# func get_topic_key_from_index(i:int) -> String:
# 	return json.data.keys()[i]

# func get_timeline(key:String)->String:
# 	return json.data[key]["static"]["timeline"]

# func get_label(key:String)->String:
# 	return json.data[key]["static"]["label"]

# func set_discovered(key:String)->bool:
# 	if json.data.has(key):
# 		json.data[key]["dynamic"]["discovered"] = true
# 		return true
# 	else:
# 		return false

# func set_clicked(key:String)->bool:
# 	if json.data.has(key):
# 		json.data[key]["dynamic"]["clicked"] = true
# 		return true
# 	else:
# 		return false

# func set_clicked_by_index(_index:int)->bool:
# 	var key = get_topic_key_from_index(_index)
# 	return set_clicked(key)

# func save()->Dictionary:
# 	var save_dict = {}
# 	for t in json.data.keys():
# 		save_dict[t] = json.data[t].dynamic	
# 	return save_dict