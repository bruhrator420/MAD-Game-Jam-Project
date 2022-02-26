extends Node2D


signal night(time)

var time = "day"

func _unhandled_input(event):
	if event.is_action_pressed("night"):
		time = "day" if time == "night" else "night"
		emit_signal("night", time)
		print(time)
