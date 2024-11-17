class_name MoDDialogicUtil extends Node


# "Vendor_Actor_1/Mystery/the_village/Clue/clue_1"
static func parse_signal_key(key:String)->Dictionary:
	var dict:Dictionary
	var key_array:Array = key.split("/",true,0)
	if key_array.size() >= 1 :
		dict["interactable"] = key_array[0]
	if key_array.size() >= 2 :
		dict["category"] = key_array[1]
	if key_array.size() >= 3 :
		dict["category_key"] = key_array[2]
	if key_array.size() >= 4 :
		dict["sub_category"] = key_array[3]
	if key_array.size() >= 5 :
		dict["sub_key"] = key_array[4]
	return dict
