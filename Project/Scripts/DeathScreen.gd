extends ColorRect


onready var popup = $"MarginContainer/ConfirmationDialog"


func _ready():
	popup.get_ok().connect("pressed", self, "_on_Quit_confirmed")


func _on_Restart_pressed():
	get_tree().reload_current_scene()


func _on_MainMenu_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_Quit_pressed():
	popup.popup_centered(Vector2(1,1)) # ??

func _on_Quit_confirmed():
	get_tree().quit()
