extends Control

export var music_vol = -20

signal Music_vol

func _ready():
	$"Menu Music/AudioStreamPlayer".volume_db = music_vol
	$Options3/CheckBox/HScrollBar.value = music_vol
	$Options3/CheckBox/HScrollBar.max_value = 24
	$Options3/CheckBox/HScrollBar.min_value = -80
	$Options3/CheckBox.pressed = true
	$"Menu Music/AudioStreamPlayer".play()
	$"Menu Music/AudioStreamPlayer2".stop()

func _on_Credits_pressed():
# warning-ignore:return_value_discarded
	$Credits2.visible = true


func _on_Play_pressed():
	$Control.visible = true


func _on_Options_pressed():
# warning-ignore:return_value_discarded
	get_tree().quit()
	



func _on_Options2_pressed():
	$Options3.visible = true


func _on_HScrollBar_value_changed(value):
	$"Menu Music/AudioStreamPlayer".volume_db = value
	emit_signal("Music_vol", $Options3/CheckBox/HScrollBar.value)


func _on_CheckBox_toggled(button_pressed):
	if button_pressed == false:
		$Options3/CheckBox/HScrollBar.visible = false
		$"Menu Music/AudioStreamPlayer".stop()
	else:
		$Options3/CheckBox/HScrollBar.visible = true
		$"Menu Music/AudioStreamPlayer".play()


func _on_Button_pressed():
	get_tree().change_scene("res://World/Tutorial.tscn")
	$Control.visible = false

func _on_Button2_pressed():
	get_tree().change_scene("res://World/World.tscn")
	$Control.visible = false
