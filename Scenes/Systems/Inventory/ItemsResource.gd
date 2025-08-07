class_name ItemsResource extends BaseResource

var _items_json: JSON
var _items_array: Array
var _items_array_as_resources: Array[ItemResource]
var _items_by_guid: Dictionary = {}

func on_load():
    _load_items_from_json()
    _create_item_resources()

func _load_items_from_json() -> void:
    var json_file = FileAccess.open("res://Data/StrapiData/Collections/Archive/items.collection.strapi.json", FileAccess.READ)
    if json_file:
        var json_string = json_file.get_as_text()
        json_file.close()
        
        var json = JSON.new()
        var parse_result = json.parse(json_string)
        
        if parse_result == OK:
            var data = json.data
            if data.has("data") and data.data is Array:
                _items_array = data.data.duplicate(true)
            else:
                _items_array = []
        else:
            print("Failed to parse items JSON")
            _items_array = []
    else:
        print("Could not open items JSON file")
        _items_array = []

func _create_item_resources() -> void:
    _items_array_as_resources.clear()
    _items_by_guid.clear()
    
    for item_data in _items_array:
        var item_resource = ItemResource.new()
        item_resource.item_data = _enhance_item_data(item_data)
        item_resource.on_load()
        _items_array_as_resources.append(item_resource)
        _items_by_guid[item_resource.get_guid()] = item_resource

func _enhance_item_data(item_data: Dictionary) -> Dictionary:
    # Enhance the item data with default values and proper structure
    var enhanced_data = item_data.duplicate(true)
    
    # Set default values for missing fields
    if not enhanced_data.has("description"):
        enhanced_data["description"] = "A mysterious item"
    
    if not enhanced_data.has("type"):
        enhanced_data["type"] = "misc"
    
    if not enhanced_data.has("rarity"):
        enhanced_data["rarity"] = "common"
    
    if not enhanced_data.has("weight"):
        enhanced_data["weight"] = 0.0
    
    if not enhanced_data.has("value"):
        enhanced_data["value"] = 0
    
    if not enhanced_data.has("max_stack"):
        enhanced_data["max_stack"] = 99
    
    if not enhanced_data.has("stackable"):
        enhanced_data["stackable"] = true
    
    return enhanced_data

func get_items() -> Array:
    return _items_array

func get_items_as_resources() -> Array[ItemResource]:
    return _items_array_as_resources

func get_item_by_guid(guid: String) -> ItemResource:
    return _items_by_guid.get(guid, null)

func get_items_by_type(item_type: String) -> Array[ItemResource]:
    var filtered_items: Array[ItemResource] = []
    for item in _items_array_as_resources:
        if item.get_item_type() == item_type:
            filtered_items.append(item)
    return filtered_items

func get_items_by_rarity(rarity: String) -> Array[ItemResource]:
    var filtered_items: Array[ItemResource] = []
    for item in _items_array_as_resources:
        if item.get_rarity() == rarity:
            filtered_items.append(item)
    return filtered_items

func create_item_from_template(template_name: String) -> ItemResource:
    # Find template item by name
    for item in _items_array_as_resources:
        if item.get_item_name() == template_name:
            var new_item = ItemResource.new()
            new_item.item_data = item.item_data.duplicate(true)
            new_item.on_load()
            return new_item
    
    # Return null if template not found
    return null

func create_custom_item(name: String, description: String = "", item_type: String = "misc", 
                       rarity: String = "common", weight: float = 0.0, value: int = 0,
                       max_stack: int = 99, stackable: bool = true) -> ItemResource:
    var custom_data = {
        "name": name,
        "description": description,
        "type": item_type,
        "rarity": rarity,
        "weight": weight,
        "value": value,
        "max_stack": max_stack,
        "stackable": stackable
    }
    
    var new_item = ItemResource.new()
    new_item.item_data = custom_data
    new_item.on_load()
    return new_item

func get_all_item_types() -> Array[String]:
    var types: Array[String] = []
    for item in _items_array_as_resources:
        var item_type = item.get_item_type()
        if not types.has(item_type):
            types.append(item_type)
    return types

func get_all_rarities() -> Array[String]:
    var rarities: Array[String] = []
    for item in _items_array_as_resources:
        var rarity = item.get_rarity()
        if not rarities.has(rarity):
            rarities.append(rarity)
    return rarities

func search_items(search_term: String) -> Array[ItemResource]:
    var search_results: Array[ItemResource] = []
    search_term = search_term.to_lower()
    
    for item in _items_array_as_resources:
        var item_name = item.get_item_name().to_lower()
        var item_description = item.get_description().to_lower()
        var item_type = item.get_item_type().to_lower()
        
        if (search_term in item_name or 
            search_term in item_description or 
            search_term in item_type):
            search_results.append(item)
    
    return search_results
