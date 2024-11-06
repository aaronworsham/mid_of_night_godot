class_name NotebookResource
extends Resource

enum topic_flags{
	TIMELINE,
	LABEL,
	DISCOVERED,
	CLICKED
}



@export var topics:Dictionary = {
	"label" : {
		topic_flags.TIMELINE : "",
		topic_flags.LABEL : "",
		topic_flags.DISCOVERED : false,
		topic_flags.CLICKED : false,
	}
}

func is_discovered(key:String)-> bool:
	return topics[key][topic_flags.DISCOVERED]

func get_topic_key_from_index(i:int) -> String:
	return topics.keys()[i]

func get_timeline(key:String)->String:
	return topics[key][topic_flags.TIMELINE]

func get_label(key:String)->String:
	return topics[key][topic_flags.LABEL]

func set_discovered(key:String)->bool:
	if topics.has(key):
		topics[key][topic_flags.DISCOVERED] = true
		return true
	else:
		return false