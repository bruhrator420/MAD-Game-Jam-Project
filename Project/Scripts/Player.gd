extends KinematicBody2D

const ACCELERATION  = 512
const MAX_SPEED = 150
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const JUMP_FORCE = 275

var hp = 3
var motion = Vector2.ZERO
var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity") *
		ProjectSettings.get_setting("physics/2d/default_gravity_vector"))

onready var sprite = $Sprite
onready var melee = $"Melee"

func _physics_process(delta):
	var kick = Input.is_action_just_pressed("attack")
	var x_input = Input.get_axis("ui_left", "ui_right")
	var use = Input.is_action_just_pressed("use")
	
	if sprite.animation != "attack":
		if kick:
			sprite.play("attack")
			melee.monitoring = true
			sprite.connect("animation_finished", self, "on_attack_animation_finished", [], CONNECT_ONESHOT)
		else:
			if use:
				var use_areas = $"Use".get_overlapping_areas()
				if not use_areas.empty():
					use_areas[0].use()
			
			if x_input:
				motion.x = move_toward(motion.x, x_input * MAX_SPEED, ACCELERATION * delta)
				sprite.flip_h = x_input < 0
				sprite.play("walk")
			else:
				sprite.play("default")
				motion.x = lerp(motion.x, 0, FRICTION if is_on_floor() else AIR_RESISTANCE)
	else:
		motion.x = lerp(motion.x, 0, FRICTION if is_on_floor() else AIR_RESISTANCE)
	
	motion += gravity * delta
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE
	else:
		if Input.is_action_just_released("jump") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
	
	motion = move_and_slide(motion, Vector2.UP)


func damage(damage = 1, knockback = Vector2.ZERO):
	hp -= damage
	if hp:
		set_deferred("motion", knockback if knockback else Vector2(0, -100))
	else:
		# morte aqui
		get_tree().paused = true


func on_attack_animation_finished():
	melee.set_deferred("monitoring", false)
	sprite.play("default")


func _on_Melee_body_entered(body):
	if body.is_in_group("enemies"):
		body.die()
