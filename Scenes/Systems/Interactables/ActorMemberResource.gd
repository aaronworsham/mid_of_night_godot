class_name ActorMemberResource extends Resource

var _name:String
var _guid:String
var _xcord:float
var _ycord:float
var _portrait_64_path:String
var _portrait_256_path:String
var _dialog_guid:String


func setup(actor:Dictionary):
	_name = actor["name"]
	_guid = actor["guid"]
	_xcord = float(actor["xcord"])
	_ycord = float(actor["ycord"])
	_portrait_64_path = actor["portrait_64_x_64"]["resPath"]
	_portrait_256_path = actor["portrait_256_x_256"]["resPath"]
	_dialog_guid = actor["dialog"]["guid"]

func get_actor_name()->String:
	return _name

func get_guid()->String:
	return _guid

func get_coords()->Vector2:
	var v:Vector2 = Vector2(_xcord,_ycord)
	return v

func get_portrait_64_path()->String:
	return _portrait_64_path

func get_portrait_256_path()->String:
	return _portrait_256_path

func get_dialog_guid()->String:
	return _dialog_guid
