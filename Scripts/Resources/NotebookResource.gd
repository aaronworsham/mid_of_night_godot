class_name NotebookResource
extends Resource

@export var json:JSON:
	set(value):
		json = value
var _threads_dict:Dictionary
var _threads_array:Array
var _discovered_threads_array:Array


func on_load():
	_threads_dict = json.data.duplicate(true)
	_threads_array.clear()
	_discovered_threads_array.clear()	
	for t in _threads_dict:
		_threads_array.append(_threads_dict[t])
		if _threads_dict[t]["state"]["discovered"] == true:
			_discovered_threads_array.append(_threads_dict[t])
	print("test")
		

func get_threads_as_dict()-> Dictionary:
	return _threads_dict

func get_threads_as_array()-> Array:
	return _threads_array

func get_keys()->Array:
	return _threads_dict.keys()
	

func get_discovered_threads()-> Array:
	return _discovered_threads_array

func set_discovered(key:String)->bool:
	if _threads_dict.has(key):
		var tmp:Dictionary = _threads_dict[key]
		tmp["state"]["discovered"] = true
		_discovered_threads_array.append(tmp)
		return true
	else:
		return false

# func get_clicked_by_key(key:String)->bool:
# 	return json.data[key]["dynamic"]["clicked"]

#this
func get_dialogic_tupal(_index:int):
	if _threads_array.size() >= _index:
		var array = [
			_threads_array[_index]["timeline"],
			_threads_array[_index]["timeline_label"]
		]
		return array
	return null

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


# func set_clicked(key:String)->bool:
# 	if json.data.has(key):
# 		json.data[key]["dynamic"]["clicked"] = true
# 		return true
# 	else:
# 		return false

#this
func set_clicked_by_index(_index:int)->bool:
	if _threads_array.size() >= _index:
		_threads_array[_index]["state"]["clicked"] = true
		return true
	return false

func is_clicked_by_index(_index:int)-> bool:
	if _threads_array.size() >= _index:
		return _threads_array[_index]["state"]["clicked"]
	return false

# func save()->Dictionary:
# 	var save_dict = {}
# 	for t in json.data.keys():
# 		save_dict[t] = json.data[t].dynamic	
# 	return save_dict
