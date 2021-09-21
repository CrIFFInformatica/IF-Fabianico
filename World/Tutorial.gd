extends Node2D



func _on_Button_pressed():
	$"Parte 1".visible = false
	$"Parte 2".visible = true


func _on_Button2_pressed():
	$"Parte 2".visible = false
	$"Parte 3".visible = true


func _on_Button3_pressed():
	$"Parte 3".visible = false
	$"Parte 5".visible = true


func _on_Button4_pressed():
	get_tree().change_scene("res://World/World.tscn")


func _on_Button5_pressed():
	$Enemy.position.x = 288
	$Enemy.position.y = 168
	$"Parte 5".visible = false
	$"Parte 4".visible = true
