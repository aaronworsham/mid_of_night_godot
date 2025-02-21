class_name TestSkillSystem extends GutTest

var skill_resource:SkillResource = SkillResource.new()

func before_all():
    skill_resource.on_load()

func before_each():
    skill_resource.reload()

func test_get_value():
    assert_eq(skill_resource.get_skill_value(SkillResource.Skills.STRENGTH),0)

func test_set_value():
    assert_eq(skill_resource.get_skill_value(SkillResource.Skills.STRENGTH),0)
    skill_resource.set_skill_value(SkillResource.Skills.STRENGTH, 10)
    assert_eq(skill_resource.get_skill_value(SkillResource.Skills.STRENGTH),10)

func test_increment_and_decrement_value():
    assert_eq(skill_resource.get_skill_value(SkillResource.Skills.STRENGTH),0)
    skill_resource.increment_skill(SkillResource.Skills.STRENGTH)
    assert_eq(skill_resource.get_skill_value(SkillResource.Skills.STRENGTH),1)
    skill_resource.decrement_skill(SkillResource.Skills.STRENGTH)
    assert_eq(skill_resource.get_skill_value(SkillResource.Skills.STRENGTH),0)
