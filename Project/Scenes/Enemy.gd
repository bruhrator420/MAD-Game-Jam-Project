extends KinematicBody2D


const SPEED = 40

var direction = -1
var motion = Vector2(SPEED * direction, 0)
var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity") *
		ProjectSettings.get_setting("physics/2d/default_gravity_vector"))

onready var floor_checker = $"FloorChecker"
onready var sprite = $"AnimatedSprite"

func _physics_process(delta):
	if is_on_wall():#  or not floor_checker.is_colliding():
		direction *= -1
		sprite.flip_h = not sprite.flip_h
		motion.x = SPEED * direction
		
	motion += gravity * delta
	
	motion = move_and_slide(motion, Vector2.UP)


func die():
	queue_free()
