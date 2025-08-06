class_name CharacterResource extends BaseResource

var _character_name:String

func on_load():
    pass

func set_character_name(n:String) ->void:
    _character_name = n

func get_character_name() -> String:
    return _character_name