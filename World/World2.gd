extends Node2D

onready var menu = $CanvasLayer/Control
onready var enemies = preload("res://Enemies/Enemy.tscn")
onready var vines = preload("res://World/VineShooter.tscn")

var enemies_deads = 0
var player_dead = false
var kill_vine = false
var Vine = null
var coins_quant = 0
var tempo = 0

signal all_enemies_dead
signal time_ended
signal finished
signal Boss_Position


func _ready():
	menu.visible = false

func _physics_process(delta):
	if Input.is_action_just_pressed("Menu"):
		menu.visible = true
	if enemies_deads == 4:
		emit_signal("all_enemies_dead")
		$BossDown.start(0.1)
		$Timer.start(6)
		enemies_deads = 0



func _on_Button_pressed():
	get_tree().change_scene("res://Menus/MainMenu.tscn")
	


func _on_Button2_pressed():
	if player_dead == true:
		pass
	else:
		$CanvasLayer/Control.visible = false




func _on_Player_player_dead():
	player_dead = true
	$CanvasLayer/Control.visible = true
	$CanvasLayer/Control/Button2.text = str("Reiniciar")
	if kill_vine == true:
		Vine.queue_free()


func _on_Timer_timeout():
	$Timer.stop()
	$BossDown.start(0.1)
	emit_signal("time_ended")
	var enemy = enemies.instance()
	var enemy2 = enemies.instance()
	var enemy3 = enemies.instance()
	var enemy4 = enemies.instance()
	add_child(enemy)
	enemy.position.y = 280
	enemy.position.x = 50
	add_child(enemy2)
	enemy2.position.y = 280
	enemy2.position.x = 200
	add_child(enemy3)
	enemy3.position.y = 280
	enemy3.position.x = 350
	add_child(enemy4)
	enemy4.position.y = 280
	enemy4.position.x = 500

func _on_EnemyChecker_body_exited(body):
	enemies_deads +=1


func _on_FinalBoss_phase2():
	Vine = vines.instance()
	kill_vine = true
#	Vine.position.x = 585
	Vine.position.y = -144
	get_parent().add_child(Vine)
	Vine.position.x = 3104


func _on_VineChecker_area_entered(area):
	if player_dead == true:
		area.queue_free()



func _on_FinalBoss_Boss_Dead():
	Vine.queue_free()
	emit_signal("finished")
	$CanvasLayer/Control4.visible = true
	$CanvasLayer/Control3.visible = true


func _on_ButtonNext_pressed():
	get_tree().change_scene("res://Menus/MainMenu.tscn")


func _on_BossDown_timeout():
	emit_signal("Boss_Position")
