class_name NightNode2D
extends Node2D


onready var children = get_children()


func _ready():
	get_tree().current_scene.connect("night", self, "_on_night")


func _on_night(time):
	for child in children:
		if child.is_in_group(time):
			child.resume()
		else:
			child.pause()
