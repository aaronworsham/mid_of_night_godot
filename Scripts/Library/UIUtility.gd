class_name UIUtility extends Node

func create_rich_copy_label(copy:String) -> RichTextLabel:
    var label = RichTextLabel.new()
    label.text = copy
    label.fit_content = true
    label.bbcode_enabled = true
    return label

func create_button(copy:String) -> Button:
    var button = Button.new()
    button.text = copy
    return button