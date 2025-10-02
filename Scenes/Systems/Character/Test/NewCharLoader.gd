class_name NewCharLoader extends Node

@onready var skills_collection_resource:SkillsCollectionResource = SkillsCollectionResource.new()
@onready var skills_json:JSON = load("res://Data/Skills/skills.json")
@onready var new_char_view:NewCharView = %NewCharView
@onready var new_char_controller:NewCharController = %NewCharController
@onready var new_char_events:NewCharEvents = %NewCharEvents
@onready var skill_template = preload("res://Scenes/Templates/CharacterSkillTemplate.tscn")


func _ready() -> void:
	skills_collection_resource.json = skills_json
	skills_collection_resource.on_load()
	var _skills = skills_collection_resource.get_all_skills() 
	for s in _skills:
		var skill_resource:SkillMemberResource = SkillMemberResource.new()
		skill_resource.setup(s)

		var skill_instance:Control = skill_template.instantiate()
		var skill_btn: Button = skill_instance.find_child("SkillBtn")
		var skill_value_btn: Button = skill_instance.find_child("SkillValueBtn")
		skill_btn.text = skill_resource.get_skill_name()
		skill_value_btn.text = str(skill_resource.get_current_value())

		new_char_view.get_skills_container().add_child(skill_instance)
	
