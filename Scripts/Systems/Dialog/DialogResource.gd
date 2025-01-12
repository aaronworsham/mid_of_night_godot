class_name DialogResource extends Resource

@export var json:JSON:
	set(value):
		json = value

#source of truth (direct from json)
var _dialogs_array:Array

#references to _threads_array
var _dialogs_dict:Dictionary


func on_load():
	
	_dialogs_array.clear()

	#source of truth
	_dialogs_array = json.data.data.duplicate(true)

	for t in _dialogs_array:
		_dialogs_dict[t["timeline_name"]] = t 

func get_timelines()-> Array:
	return _dialogs_dict.keys()

func get_instructions(timeline:String) -> Array:
	var a:Array
	if _dialogs_dict.has(timeline):
		if _dialogs_dict[timeline]["instructions"].is_empty():
			return a
		for i:Dictionary in _dialogs_dict[timeline]["instructions"]:
			if i["children"].is_empty():
				continue
			else:
				for c in i["children"]:
					var line = decode_from_straip(c["text"])
					a.append(line)
	return a

func decode_from_straip(line:String)-> String:
	line = line.replace("{choice}","-")
	line = line.replace("{indent}","	")
	return line


