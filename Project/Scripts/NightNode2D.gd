class_name NightNode2D
extends Node2D


onready var children = get_children()


func _on_Level_night(time):
	for child in children:
		if child.is_in_group(time):
			child.resume()
		else:
			child.pause()
