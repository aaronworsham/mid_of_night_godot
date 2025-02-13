class_name ResearchTopicCollectionResource extends Resource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _research_topics_array:Array

#references to _research_topics_array by guid
var _research_topics_dict:Dictionary


func on_load():
    
    _research_topics_array.clear()

    #source of truth
    _research_topics_array = json.data.data.duplicate(true)

    for t in _research_topics_array:
        _research_topics_dict[t["guid"]] = t

func get_research_topic_by_guid(guid:String) -> Dictionary:
    return _research_topics_dict[guid]

func get_all_discovered_research_topics()-> Array:
    return _research_topics_array