extends GutTest

@onready var json:JSON = load("res://Data/CaseFiles/Mysteries/Mysteries.json")
var x:Dictionary

func test_setup():
	x = json.data
	assert_eq("The Village",x["the_village"]["description"])
