extends KinematicBody2D

const ACCELERATION  = 512
const MAX_SPEED = 150
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const GRAVITY = 450
const JUMP_FORCE = 275

var motion = Vector2.ZERO

onready var sprite = $Sprite

func _physics_process(delta):
	var x_input = Input.get_axis("ui_left", "ui_right")
	
	if x_input:
		motion.x = move_toward(motion.x, x_input * MAX_SPEED, ACCELERATION * delta)
		sprite.flip_h = x_input < 0
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
	
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE
	else:
		if Input.is_action_just_released("jump") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
	
	motion = move_and_slide(motion, Vector2.UP)
