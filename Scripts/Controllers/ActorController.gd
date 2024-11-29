class_name ActorController
extends StaticBody2D

@onready var querty_ui = self.get_node("/root/Main/UIOverlay/NotebookUI")
@onready var query_field = self.get_node("/root/Main/UIOverlay/NotebookUI").get_node("%QueryEdit")
@export var actor_resource:ActorResource
@export var notebook_resource:NotebookResource
@export var dialog_timeline:DialogicTimeline
@export var thread_resource:ThreadResource

func _ready() -> void:
	EventManager.event_start_dialog.connect(dialog_action)

func dialog_action(_act:ActorController) -> void:
	print("ActorController: Got signal from DetectiveController")
	querty_ui.visible = true

func save()->Dictionary:
	var save_dict = {
		"filename" : get_scene_file_path(),
		"node_type" : "actor",
		"script_name" : "ActorController",
		"node_name" : self.name,
		"exports" : {
			"resources":{
				"actor_resource" : actor_resource.save(),
				"notebook_resource" : notebook_resource.save(),
			},
			"dialog_timeline" : dialog_timeline.to_string(),
		}
	}
	return save_dict

func load(_data:Dictionary)->void:
	for x in _data["exports"]["resources"]["notebook_resource"].keys():
		print("ActorController Loading X key: "+x)
		for y in _data["exports"]["resources"]["notebook_resource"][x].keys():
			print("ActorController Loading Y key: "+y)
			print("ActorController Loading Y value: ")
			print(_data["exports"]["resources"]["notebook_resource"][x][y])
			
			notebook_resource.set_dynamic_data(x,y, _data["exports"]["resources"]["notebook_resource"][x][y])
