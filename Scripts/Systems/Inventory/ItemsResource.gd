class_name ItemsResource extends BaseResource

var _items_json:JSON
var _items_array:Array
var _items_array_as_resources:Array

func on_load():
    _items_json = load("res://Data/StrapiData/Collections/items.collection.strapi.json")
    _items_array = _items_json.data.data.duplicate(true)
    _items_array_as_resources.clear()

    for i in _items_array:
        var ir:ItemResource = ItemResource.new()
        ir.item_data = i
        ir.on_load()
        _items_array_as_resources.append(ir)



func get_items()-> Array:
    return _items_array

func get_items_as_resources()-> Array:
    return _items_array_as_resources
