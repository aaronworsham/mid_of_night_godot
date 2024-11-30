class_name ThreadResource extends BaseResource

@export var json:JSON:
	set(value):
		json = value

#source of truth (direct from json)
var _threads_array:Array

#references to _threads_array
var _threads_dict_by_key:Dictionary
var _threads_dict_by_guid:Dictionary


func on_load():
	
	_threads_array.clear()
	_threads_dict_by_guid.clear()
	_threads_dict_by_key.clear()

	#source of truth
	_threads_array = json.data.data.duplicate(true)

	for t in _threads_array:
		_threads_dict_by_key[t["thread_key"]] = t 
		_threads_dict_by_guid[t["guid"]] = t 

func get_all_instructions_by_thread_guid()-> Dictionary:
	var tmpaD:Dictionary
	for t in _threads_array:
		tmpaD[t["guid"]] = {
			"thread_key":t["thread_key"],
			"thread_guid":t["guid"],
			"actor":t["actor"],
			"instructions":t["instructions"]
		}
	return tmpaD

func get_instructions_for_key(key:String) -> Array:
	if _threads_dict_by_key.has(key):
		var instructions = _threads_dict_by_key[key]["instructions"]
		return instructions
	return []

func get_timeline(key:String)-> DialogicTimeline:
	var tmpA:Array
	var timeline:DialogicTimeline = DialogicTimeline.new()
	if _threads_dict_by_key.has(key):
		tmpA = get_instructions_for_key(key)
		timeline.events = tmpA
		timeline.process()
		if timeline.events_processed:
			return timeline
	return DialogicTimeline.new()
