class_name ChanceOfSuccessResource extends BaseResource

enum CosTier {
    SUCCESS,
    FAILURE

}

var dice_roll:int:
    set(value):
        dice_roll = value

var skill:SkillMemberResource:
    set(value):
        skill = value

var skill_value:int:
    set(value):
        skill_value = value

func on_load(r:int, s:SkillMemberResource, sv:int) -> void:
    dice_roll = r
    skill = s
    skill_value = sv

func is_success() -> bool:
    return dice_roll < skill_value

func  get_cos_tier() -> CosTier:
    if dice_roll < skill_value:
        return CosTier.SUCCESS
    else:
        return CosTier.FAILURE