class_name ResearchCategoryCollectionResource extends Resource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _research_categories_array:Array

#references to _research_categories_array by guid
var _research_categories_dict:Dictionary


func on_load():
    
    _research_categories_array.clear()

    #source of truth
    _research_categories_array = json.data.data.duplicate(true)

    for t in _research_categories_array:
        _research_categories_dict[t["guid"]] = t

func get_research_category_by_guid(guid:String) -> Dictionary:
    return _research_categories_dict[guid]

func get_all_discovered_research_categories()-> Array:
    return _research_categories_array