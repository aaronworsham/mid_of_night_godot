class_name TestSkillSystem extends GutTest

var skill_resource:SkillMemberResource = SkillMemberResource.new()

var skill_dict:Dictionary = {
        "enum": "STRENGTH",
        "guid": "skill_strength",
        "name": "Strength",
        "description": "A measure of your physical power.",
        "associated_attribute": "STRENGTH",
        "default_value": 10
    }

var skills_collection_resource:SkillsCollectionResource = SkillsCollectionResource.new()

var skills_json:JSON = load("res://UnitTests/StrapiData/test_skills.json")

func before_each():
    skill_resource.setup(skill_dict)
    skills_collection_resource.json = skills_json
    skills_collection_resource.on_load()

func test_get_value():
    assert_eq(skill_resource.get_current_value(), 10)

func test_set_value():
    assert_eq(skill_resource.get_current_value()  ,10)
    skill_resource.set_current_value(100)
    assert_eq(skill_resource.get_current_value()  ,100)

func test_get_skill_by_enum():
    var skill:SkillMemberResource = skills_collection_resource.get_member_by_enum("STRENGTH")
    assert_eq(skill.get_enum(), "STRENGTH")
    assert_eq(skill.get_guid(), "skill_strength")
    assert_eq(skill.get_skill_name(), "Strength")
    assert_eq(skill.get_description(), "A measure of your physical power.")
    assert_eq(skill.get_associated_attribute(), "STRENGTH")
    assert_eq(skill.get_default_value(), 10)
    assert_eq(skill.get_current_value(), 10)



