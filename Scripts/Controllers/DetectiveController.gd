class_name DetectiveController
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var anim_tree = get_node("AnimationTree")
@onready var querty_ui = get_node("/root/Main/UIOverlay/NotebookUI")
@onready var query_field = get_node("/root/Main/UIOverlay/NotebookUI").get_node("%QueryEdit")
var speed: int = 50  # speed in pixels/sec
var facing = Vector2.ZERO;
var lock_movement: bool = false



func _physics_process(_delta):
		
	if lock_movement == true:
		return

	#Set Velocity
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	
	#this is a test 3
	if direction == Vector2.ZERO:
		anim_tree.get("parameters/playback").travel("Idle")
		anim_tree.set("parameters/Idle/BlendSpace2D/blend_position", facing)
	else:
		anim_tree.get("parameters/playback").travel("Walk")
		anim_tree.set("parameters/Walk/BlendSpace2D/blend_position", direction)
		facing = direction
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_pressed("dialogic_default_action"):
			var actionables = actionable_finder.get_overlapping_areas()
			if actionables.size() > 0:
				lock_movement = true
				#send the Actor
				EventManager.emit_event_start_dialog(actionables[0].get_parent())
				#actionables[0].dialog_action()
				get_viewport().set_input_as_handled()
				return


