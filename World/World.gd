extends Node2D

var cooldownTime = 1
var player_dead = false
var coin_quantity = 20
var enemy_deads = 0
var show_easter_egg = false
var coxinha = 0
var coquinha = 0
var almoco = 0

onready var butao = $CanvasLayer/Control
onready var butao1 = $CanvasLayer/Control/Button2
onready var butao2 = $CanvasLayer/Control2
onready var show_iten = $"CanvasLayer/Item baú/Label"
onready var iten_vis = $"CanvasLayer/Item baú"
onready var iten_timer = $"CanvasLayer/Item baú/Iten_timer"
onready var cooldown = $Timer
onready var player = $Player

signal Coin_quant
signal Next_phase
signal ItensCantinaCox
signal ItensCantinaCoq
signal ItensCantinaAlm

func _ready():
	butao.visible = false
	butao2.visible = false
	cooldown.set_wait_time(5)
	$"Node2D/AudioStreamPlayer2".play()
	
func _process(delta):
	if enemy_deads == 17 and coin_quantity == 15 and $Player.player_health >= 3:
		show_easter_egg = true
	
	if Input.is_action_just_pressed("Menu"):
		butao.visible = true
		player_dead = false
	if Input.is_action_just_pressed("SpecialAttack"):
		if cooldownTime == 1:
			
			cooldown.start()
			cooldownTime = 0
			
		if cooldownTime == 0:
			pass


func _on_Button2_pressed():
	butao.visible = false
	if player_dead == true:
		get_tree().change_scene("res://World/World.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://Menus/MainMenu.tscn")


func _on_Timer_timeout():
	
	cooldownTime = 1


func _on_Area2D_body_entered(body):
	butao.visible = true
	butao1.text = str("Reiniciar")
	player_dead = true
	player.queue_free()


func _on_Player_player_dead():
	butao.visible = true
	player_dead = true
	butao1.text = str("Reiniciar")


func _on_Chest_Iten1():
	show_iten.text = str("Você ganhou:" + "       " + "Bota (+ Velocidade)")
	iten_vis.visible = true
	iten_timer.start(3)


func _on_Chest_Iten2():
	show_iten.text = str("Você ganhou:" + "       " + "Cinto (+ Energia)")
	iten_vis.visible = true
	iten_timer.start(3)


func _on_Chest_Iten3():
	show_iten.text = str("Você ganhou:" + "       " + "Luva (+ Dano)")
	iten_vis.visible = true
	iten_timer.start(3)


func _on_Chest_Iten4():
	show_iten.text = str("Você ganhou:" + "       " + "Armadura (+ Vida)")
	iten_vis.visible = true
	iten_timer.start(3)


func _on_Iten_timer_timeout():
	iten_vis.visible = false


func _on_Area2D2_body_entered(body):
	$CanvasLayer/Control5.visible = true
	$CanvasLayer/Control5/Label2.text = str("Seu Dinheiro: ", coin_quantity)


func _on_ButtonNext_pressed():

	$CanvasLayer/Control2.visible = false
	
	


func _on_Node2D_Music_vol(value):
	$Node2D/AudioStreamPlayer2.volume_db = value


func _on_Coin_body_entered(body):
	coin_quantity += 1


func _on_EnemyMorto_body_exited(body):
	enemy_deads += 1



func _on_SmoothCamera_timeout():
	$Camera2D.smoothing_enabled = true


func _on_ButtonCox_pressed():
	$CanvasLayer/Control5/Label6.visible = false
	if coin_quantity >=5:
		coxinha = coxinha + 1
		coin_quantity = coin_quantity - 5
		$CanvasLayer/Control5/Label2.text = str("Seu Dinheiro: ", coin_quantity)
		emit_signal("ItensCantinaCox")
	else:
		$CanvasLayer/Control5/Label6.visible = true


func _on_ButtonCoqui_pressed():
	$CanvasLayer/Control5/Label6.visible = false
	if coin_quantity >= 10:
		coquinha = coquinha + 1
		coin_quantity = coin_quantity - 10
		$CanvasLayer/Control5/Label2.text = str("Seu Dinheiro: ", coin_quantity)
		emit_signal("ItensCantinaCoq")
	else:
		$CanvasLayer/Control5/Label6.visible = true


func _on_ButtonAlmo_pressed():
	$CanvasLayer/Control5/Label6.visible = false
	if coin_quantity >=15:
		almoco = almoco + 1
		coin_quantity = coin_quantity - 15
		$CanvasLayer/Control5/Label2.text = str("Seu Dinheiro: ", coin_quantity)
		emit_signal("ItensCantinaAlm")
	else:
		$CanvasLayer/Control5/Label6.visible = true


func _on_Continue_pressed():
	emit_signal("Next_phase")
	$CanvasLayer/Control5.visible = false
