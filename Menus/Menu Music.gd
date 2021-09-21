extends Node2D


signal Music_vol

func _on_MainMenu_Music_vol(value):
	emit_signal("Music_vol",value)
