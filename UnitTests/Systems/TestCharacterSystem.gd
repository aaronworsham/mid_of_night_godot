class_name TestCharacterSystem extends GutTest

var character_resource:CharacterResource = CharacterResource.new()


func test_character_settings():
	assert_eq(character_resource.get_character_name(), "")
	character_resource.set_character_name("Test")
	assert_eq(character_resource.get_character_name(), "Test")

func test_character_manager():
	assert_eq(CharacterManager.get_character_name(), "")
	CharacterManager.set_character_name("Test")
	assert_eq(CharacterManager.get_character_name(), "Test")

# func test_get_value():
#     assert_eq(CharacterManager.get_skill_value(SkillResource.Skills.STRENGTH),0)

# func test_set_value():
#     assert_eq(CharacterManager.get_skill_value(SkillResource.Skills.STRENGTH),0)
#     CharacterManager.set_skill_value(SkillResource.Skills.STRENGTH, 10)
#     assert_eq(CharacterManager.get_skill_value(SkillResource.Skills.STRENGTH),10)

# func test_increment_and_decrement_value():
#     assert_eq(CharacterManager.get_skill_value(SkillResource.Skills.STRENGTH),0)
#     CharacterManager.increment_skill(SkillResource.Skills.STRENGTH)
#     assert_eq(CharacterManager.get_skill_value(SkillResource.Skills.STRENGTH),1)
#     CharacterManager.decrement_skill(SkillResource.Skills.STRENGTH)
#     assert_eq(CharacterManager.get_skill_value(SkillResource.Skills.STRENGTH),0)
