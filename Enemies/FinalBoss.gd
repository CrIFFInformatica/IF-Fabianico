extends KinematicBody2D

onready var bullet = preload("res://Enemies/Range Projectile.tscn")

var player = null
var phase2 = false
var move = Vector2.ZERO
var direction_vec = Vector2.ZERO
var speed = 2
var gou = false
var god = false
var is_going = 0

signal Boss_Dead
signal phase2

func _ready():
	$Timer.start(1)

func _physics_process(delta):
	$Control/Label.text = str($Stats.health)
	if Input.is_action_just_pressed("IK"):
		$Stats.health = $Stats.health - $Stats.health


func _on_Stats_no_health():
	if phase2 == false:
		phase2 = true
		emit_signal("phase2")
		$Stats.health = $Stats.max_health
	else:
		queue_free()
		emit_signal("Boss_Dead")
	
	


func _on_Area2D_area_entered(area):
	$Stats.health -= area.damage


func _on_Timer_timeout():
	if player != null:
		fire()

func fire():
	var Bullet = bullet.instance()
	if player != null:
		Bullet.position.x = position.x
		Bullet.position.y = position.y
		Bullet.player = player
		get_parent().add_child(Bullet)
		$Timer.set_wait_time(1)

func _on_Area2D2_body_entered(body):
	player = body


func _on_Area2D2_body_exited(body):
	player = null


func _on_World2_all_enemies_dead():
	god = true


func _on_World2_time_ended():
	gou = true



func _on_World2_Boss_Position():
	if god == true:
		if is_going < 21:
			position.y = position.y + 10
			is_going = is_going + 1
		if is_going == 21:
			god = false
			is_going = 0
	if gou == true:
		if is_going < 21:
			position.y = position.y - 10
			is_going = is_going + 1
		if is_going == 21:
			gou = false
			is_going = 0
