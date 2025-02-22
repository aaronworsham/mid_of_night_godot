class_name TestChanceOfSuccessSystem extends GutTest

var dice_manager:DiceManager = DiceManager.new()
var cos_resource:ChanceOfSuccessResource = ChanceOfSuccessResource.new()
var set_skill:SkillResource.Skills = SkillResource.Skills.STRENGTH

    

func test_random_roll():
    var r:int = dice_manager.roll_d100()
    assert_gt(r,0)
    assert_lt(r,101)

func test_set_roll():
    dice_manager.set_result(50)
    var r:int = dice_manager.roll_d100()
    assert_eq(r,50)

func test_cos_success():
    cos_resource.on_load(50, set_skill, 60)
    assert_true(cos_resource.is_success())

func test_cos_failure():
    cos_resource.on_load(50, set_skill, 40)
    assert_false(cos_resource.is_success())

func test_cos_tier():
    cos_resource.on_load(50, set_skill, 60)
    var tier:ChanceOfSuccessResource.CosTier = cos_resource.get_cos_tier()
    assert_eq(tier, ChanceOfSuccessResource.CosTier.SUCCESS)
    cos_resource.on_load(50, set_skill, 40)
    tier = cos_resource.get_cos_tier()
    assert_eq(tier, ChanceOfSuccessResource.CosTier.FAILURE)
