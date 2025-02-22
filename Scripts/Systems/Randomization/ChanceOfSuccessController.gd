class_name ChanceOfSuccessManager extends Node

var dice_manager:DiceManager = DiceManager.new()

func _ready() -> void:
    EventManager.event_cos_get_cos.connect(get_cos)


func get_cos(s:SkillResource.Skills, sv:int)->ChanceOfSuccessResource:
    var cos1:ChanceOfSuccessResource = ChanceOfSuccessResource.new()
    var r = dice_manager.roll_d100()
    cos1.on_load(r,s,sv)
    return cos1
