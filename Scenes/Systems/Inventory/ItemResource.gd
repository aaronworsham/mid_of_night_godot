class_name ItemResource extends BaseResource

var item_data:Dictionary:
    set(value):
        item_data = value

var _count:int = 1
var _guid:String
var _max_stack_size:int = 99
var _is_stackable:bool = true
var _item_type:String = "misc"
var _rarity:String = "common"
var _weight:float = 0.0
var _value:int = 0
var _description:String = ""

func on_load():
    _guid = UUID.v7()
    _parse_item_data()

func _parse_item_data() -> void:
    if item_data.has("name"):
        # Parse existing data structure
        pass
    else:
        # Set default values for new items
        item_data = {
            "name": "Unknown Item",
            "description": "A mysterious item",
            "type": "misc",
            "rarity": "common",
            "weight": 0.0,
            "value": 0,
            "max_stack": 99,
            "stackable": true
        }

func increment_count() -> void:
    if _is_stackable and _count < _max_stack_size:
        _count += 1

func decrement_count() -> void:
    if _count > 0:
        _count -= 1

func set_count(c:int) -> void:
    _count = clamp(c, 0, _max_stack_size)

func get_count() -> int:
    return _count

func get_item_name() -> String:
    return item_data.get("name", "Unknown Item")

func get_guid() -> String:
    return _guid

func get_description() -> String:
    return item_data.get("description", "No description available")

func get_item_type() -> String:
    return item_data.get("type", "misc")

func get_rarity() -> String:
    return item_data.get("rarity", "common")

func get_weight() -> float:
    return item_data.get("weight", 0.0)

func get_value() -> int:
    return item_data.get("value", 0)

func get_max_stack_size() -> int:
    return item_data.get("max_stack", 99)

func is_stackable() -> bool:
    return item_data.get("stackable", true)

func get_total_weight() -> float:
    return _weight * _count

func get_total_value() -> int:
    return _value * _count

func can_stack_with(other_item: ItemResource) -> bool:
    if not _is_stackable or not other_item.is_stackable():
        return false
    return _guid == other_item.get_guid()

func get_rarity_color() -> Color:
    match _rarity:
        "common":
            return Color.WHITE
        "uncommon":
            return Color.GREEN
        "rare":
            return Color.BLUE
        "epic":
            return Color.PURPLE
        "legendary":
            return Color.ORANGE
        _:
            return Color.WHITE

func to_dict() -> Dictionary:
    return {
        "guid": _guid,
        "count": _count,
        "item_data": item_data
    }

func from_dict(data: Dictionary) -> void:
    _guid = data.get("guid", UUID.v7())
    _count = data.get("count", 1)
    item_data = data.get("item_data", {})
    _parse_item_data()

 
