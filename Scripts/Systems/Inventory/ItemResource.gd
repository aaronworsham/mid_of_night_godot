class_name ItemResource extends BaseResource

var _name:String
var _count:int
var _guid:String

func on_load():
    _guid = UUID.v7()

func increment_count() -> void:
    _count += 1

func decrement_count() -> void:
    _count -= 1

func set_count(c:int) -> void:
    _count = c

func get_count()->int:
    return _count

func set_item_name(n:String) -> void:
    _name = n

func get_item_name()->String:
    return _name

func get_guid()->String:
    return _guid

 
