class_name ThreadResource extends BaseResource

@export var json:JSON:
    set(value):
        json = value

#source of truth (direct from json)
var _threads_array:Array

#references to _threads_array
var _threads_dict_by_key:Dictionary
var _threads_dict_by_guid:Dictionary


func on_load():
    
    _threads_array.clear()
    _threads_dict_by_guid.clear()
    _threads_dict_by_key.clear()

    #source of truth
    _threads_array = json.data.data.duplicate(true)

    for t in _threads_array:
        _threads_dict_by_key[t["thread_key"]] = t 
        _threads_dict_by_guid[t["guid"]] = t 

func get_all_parsed_instructions_by_thread_guid()-> Dictionary:
    var tmpaD:Dictionary
    var tmpbA:Array

    for t in _threads_array:
        tmpbA = parse_instructions(t["instructions"],t["thread_key"])
        tmpaD[t["guid"]] = {
            "thread_key":t["thread_key"],
            "thread_guid":t["guid"],
            "actor":t["actor"],
            "instructions":tmpbA
        }
    return tmpaD

func get_parsed_instructions_for_key(key:String) -> Array:
    var tmpA:Array
    if _threads_dict_by_key.has(key):
        var instructions = _threads_dict_by_key[key]["instructions"]
        tmpA = parse_instructions(instructions, key)
        return tmpA
    return []

func get_timeline(key:String)-> DialogicTimeline:
    var tmpA:Array
    var timeline:DialogicTimeline = DialogicTimeline.new()
    if _threads_dict_by_key.has(key):
        tmpA = get_parsed_instructions_for_key(key)
        timeline.events = tmpA
        timeline.process()
        if timeline.events_processed:
            return timeline
    return DialogicTimeline.new()


func parse_instructions(instructions:Array, thread_key:String) -> Array:
    var tmpA:Array
    for i in instructions:
        match i["__component"]:
            "timeline.timeline-dialog":
                print("Got Dialog")
                tmpA.append(i["text"])
            "timeline.timeline-signal":
                print ("Got Signal")
                tmpA.append(MoDDialogicUtil.generate_signal_key(thread_key,i))
            "timeline.thread-voiceover":
                print ("Got Voiceover")
                #[voice path="res://Dialog/MainVO/Audio/test_audio.ogg" volume="0.0"]
                #tmpS="[voice path='res://"+i["male_vo_file"]["url"]+"' volume='0.0']"
                var tmpS="[voice path='res://Dialog/MainVO/Audio/test_audio.ogg' volume='0.0']"
                tmpA.append(tmpS)
    return tmpA
