class_name DialogicSignalUtil extends Node


# "Vendor_Actor_1/Mystery/the_village/Clue/clue_1"
static func parse_signal_key(key:String)->Dictionary:
	var dict:Dictionary
	var key_array:Array = key.split("/",true,0)
	dict["interactable"] = key_array[0]
	dict["casefile"] = key_array[1]
	dict["casefile_key"] = key_array[2]
	dict["sub_category"] = key_array[3]
	dict["sub_key"] = key_array[4]
	return dict