class_name TestSkillSystem extends GutTest

var skill_resource:SkillMemberResource = SkillMemberResource.new()

var skill_dict:Dictionary = {
        "enum": "STRENGTH",
        "guid": "1234-5678-9012-3456",
        "name": "Strength",
        "description": "A measure of physical power and force.",
        "associated_attribute": "POWER",
        "default_value": 0
    }

var skills_collection_resource:SkillsCollectionResource = SkillsCollectionResource.new()

var skills_json:JSON = load("res://UnitTests/StrapiData/test_skills.json")

func before_each():
    skill_resource.setup(skill_dict)
    skills_collection_resource.json = skills_json
    skills_collection_resource.on_load()

func test_get_value():
    assert_eq(skill_resource.get_current_value(), 0)

func test_set_value():
    assert_eq(skill_resource.get_current_value()  ,0)
    skill_resource.set_current_value(10)
    assert_eq(skill_resource.get_current_value()  ,10)



