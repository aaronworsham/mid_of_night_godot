class_name ItemResource extends BaseResource

var item_data:Dictionary:
    set(value):
        item_data = value

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

func get_item_name()->String:
    return item_data["name"]

func get_guid()->String:
    return _guid

 
