class_name ActorController extends Node

var actors:Dictionary

func _ready() -> void:
    EventManager.event_start_dialog.connect(dialog_action)
    EventManager.event_actor_loaded.connect(add_actor)

func dialog_action(_act:ActorController) -> void:
    pass

func add_actor(actor:ActorModel):
    actors[actor.get_guid()] = actor
    print("Actor Loaded")


# func save()->Dictionary:
#     var save_dict = {
#         "filename" : get_scene_file_path(),
#         "node_type" : "actor",
#         "script_name" : "ActorController",
#         "node_name" : self.name,
#         "exports" : {
#             "resources":{
#                 # "actor_resource" : actor_resource.save(),
#                 "notebook_resource" : notebook_resource.save(),
#             },
#             "dialog_timeline" : dialog_timeline.to_string(),
#         }
#     }
#     return save_dict

# func load(_data:Dictionary)->void:
#     for x in _data["exports"]["resources"]["notebook_resource"].keys():
#         for y in _data["exports"]["resources"]["notebook_resource"][x].keys():
#             print("ActorController Loading Y key: "+y)
#             print("ActorController Loading Y value: ")
#             print(_data["exports"]["resources"]["notebook_resource"][x][y])
            
#             notebook_resource.set_dynamic_data(x,y, _data["exports"]["resources"]["notebook_resource"][x][y])
