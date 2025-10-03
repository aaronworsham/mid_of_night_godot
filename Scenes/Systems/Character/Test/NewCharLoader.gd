class_name NewCharLoader extends Node

@onready var skills_collection_resource:SkillsCollectionResource = SkillsCollectionResource.new()
@onready var skills_json:JSON = load("res://Data/Character/skills.json")
@onready var characteristics_collection_resource:CharacteristicsCollectionResource = CharacteristicsCollectionResource.new()
@onready var characteristics_json:JSON = load("res://Data/Character/characteristics.json")
@onready var new_char_view:NewCharView = %NewCharView
@onready var new_char_controller:NewCharController = %NewCharController
@onready var new_char_events:NewCharEvents = %NewCharEvents
@onready var skill_template = preload("res://Scenes/Templates/CharacterSkillTemplate.tscn")
@onready var characteristic_template = preload("res://Scenes/Templates/CharacterCharacteristicTemplate.tscn")


func _ready() -> void:
	skills_collection_resource.json = skills_json
	skills_collection_resource.on_load()
	characteristics_collection_resource.json = characteristics_json
	characteristics_collection_resource.on_load()
	var _skills = skills_collection_resource.get_all_members() 
	for s in _skills:
		var skill_resource:SkillMemberResource = SkillMemberResource.new()
		skill_resource.setup(s)

		var skill_instance:Control = skill_template.instantiate()
		var skill_label: Label = skill_instance.find_child("SkillLabel")
		var skill_value_input: LineEdit = skill_instance.find_child("SkillValueInput")

		skill_label.text = skill_resource.get_skill_name()
		skill_value_input.text = str(skill_resource.get_current_value())

		new_char_view.get_skills_container().add_child(skill_instance)

	for c in characteristics_collection_resource.get_all_members():
		var characteristics_resource:CharacteristicsMemberResource = CharacteristicsMemberResource.new()
		characteristics_resource.setup(c)

		var characteristic_instance:Control = characteristic_template.instantiate()
		var characteristic_label: Label = characteristic_instance.find_child("CharacteristicLabel")
		var characteristic_value_input: LineEdit = characteristic_instance.find_child("CharacteristicInput")

		characteristic_label.text = characteristics_resource.get_characteristic_name()
		characteristic_value_input.text = str(characteristics_resource.get_current_value())

		new_char_view.get_characteristics_container().add_child(characteristic_instance)
	
