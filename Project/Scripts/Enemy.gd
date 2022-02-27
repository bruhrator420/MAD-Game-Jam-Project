extends KinematicBody2D


const SPEED = 40

var direction = -1
var motion = Vector2(SPEED * direction, 0)
var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity") *
		ProjectSettings.get_setting("physics/2d/default_gravity_vector"))

onready var floor_checker = $"FloorChecker"
onready var sprite = $"AnimatedSprite"

func _physics_process(delta):
	if is_on_wall() or not floor_checker.is_colliding():
		direction *= -1
		sprite.flip_h = not sprite.flip_h
		motion.x = SPEED * direction
		floor_checker.position.x *= -1
	
	motion += gravity * delta
	
	motion = move_and_slide(motion, Vector2.UP)


func die():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("players"):
		body.damage(1, Vector2(156 * sign(body.global_position.x - global_position.x), -100))
