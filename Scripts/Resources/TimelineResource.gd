class_name TimelineResource extends BaseResource

var _threads_resource:ThreadResource:
	set(value):
		_threads_resource = value

#source of truth (direct from json)
var _timelines_dict_by_actor_guid:Dictionary

#references to _threads_array


func on_load():
	
	_timelines_dict_by_actor_guid.clear()

	if _threads_resource != null:
		var tmpaD:Dictionary = _threads_resource.get_all_parsed_instructions_by_thread_guid()

		for t:String in tmpaD:
			var actor_guid = tmpaD[t]["actor"]["guid"]
			var thread_key = tmpaD[t]["thread_key"]
			if !_timelines_dict_by_actor_guid.has(actor_guid):
				_timelines_dict_by_actor_guid[actor_guid] = {}
			_timelines_dict_by_actor_guid[actor_guid][thread_key] = tmpaD[t]["instructions"]

				
		

func get_threads_for_actor_guid(guid:String) -> Dictionary:
	if _timelines_dict_by_actor_guid.has(guid):
		return _timelines_dict_by_actor_guid[guid]
	return {}
