extends Node2D


signal night(time)

export(String, "day", "night") var time = "day"


func _ready():
	emit_signal("night", time)


func _unhandled_input(event):
	if event.is_action_pressed("night"):
		time = "day" if time == "night" else "night"
		emit_signal("night", time)
		print(time)


func _on_Area2D_body_entered(body):
	print("lole")
	if body.is_in_group("players"):
		get_tree().change_scene("res://Scenes/2.tscn")
