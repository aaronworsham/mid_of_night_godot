class_name MoDDialogicUtil extends Node


# "Vendor_Actor_1/Mystery/the_village/Clue/clue_1"
static func parse_signal_key(signalS:String)->Dictionary:
	var dict:Dictionary
	var key_value_array:Array = signalS.split("|",true,0)
	for kv:String in key_value_array:
		var tmpA:Array = kv.split(":",true,0)
		dict[tmpA[0]] = tmpA[1]
	return dict

static func generate_signal_key(thread_key:String, i:Dictionary)-> String:
	var tmpD = {
		"thread_key":thread_key,
		"category_key":i["category_key"],
		"label":i["label"],
		"actor":i["actor"]["guid"]
	}
	
	var tmpS_format = "[signal arg=\"thread_key:{thread_key}|category_key:{category_key}|label:{label}|actor:{actor}\"]"
	var tmpS= tmpS_format.format(tmpD)
	return tmpS
