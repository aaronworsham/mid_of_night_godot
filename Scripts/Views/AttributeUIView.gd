class_name AttributeUIView
extends Node

@onready var att_label: RichTextLabel = %AttributeLabel

func _ready() -> void:
	EventManager.event_attributes_updated.connect(_recieve_attributes_update)
	att_label.text = "temp"

func _recieve_attributes_update(atts:Dictionary):
	var strength = atts[DetectiveModel.AttributeNames.STRENGTH]
	print("got Signal")
	print(strength)
	var format_string = "Strength is %s"
	att_label.text = format_string % strength
	print("Testing Translation")
	print(tr("TEST"))
	print(tr("TEST2"))
	print(tr("TEST.TEST"))
	
