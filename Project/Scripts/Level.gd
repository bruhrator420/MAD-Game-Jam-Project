extends Node2D


signal night(time)

export(String, "day", "night") var time = "day"

var transition_player = AudioStreamPlayer.new()
var transition_audio = preload("res://Assets/Sounds/Transition.ogg")

func _ready():
	emit_signal("night", time)
	add_child(transition_player)
	transition_player.owner = self
	transition_player.stream = transition_audio
	transition_audio.loop = false
	transition_player.volume_db = -20


func _unhandled_input(event):
	if event.is_action_pressed("night"):
		transition_player.play(0.7)
		time = "day" if time == "night" else "night"
		emit_signal("night", time)
		print(time)


func _on_Area2D_body_entered(body, scene_path):
	if body.is_in_group("players"):
		get_tree().change_scene(scene_path)


func _on_Fallzone_body_entered(body):
	if body.is_in_group("players"):
		body.die()


func _on_Fallzone2_body_entered(body):
	pass # Replace with function body.
