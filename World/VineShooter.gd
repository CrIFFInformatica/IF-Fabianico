extends Area2D

onready var bullet = preload("res://Enemies/Range Projectile.tscn")

var player = null

func _ready():
	$AnimationPlayer.play("Shoot")
	
func _physics_process(delta):
	if $CollisionPolygon2D.disabled == true:
		fire()

func fire():
	var Bullet = bullet.instance()
	if player != null:
		Bullet.position.y = position.y
		Bullet.position.x = position.x
		Bullet.player = player
		get_parent().add_child(Bullet)


func _on_Area2D_body_entered(body):
	player = body
