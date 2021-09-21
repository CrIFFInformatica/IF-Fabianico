extends KinematicBody2D

onready var EnemyStats = $Stats
onready var Bullet = preload("res://Enemies/Range Projectile.tscn")

var player = null

func _ready():
	$Sprite.flip_h = false
func _physics_process(delta):
	$Control/Label.text = str(EnemyStats.health)
	$AnimationPlayer.play("Idle")
	if player != null:
		if player.position.x - global_position.x < 0:
			$Sprite.flip_h = false
		if player.position.x - global_position.x  > 0:
			$Sprite.flip_h = true
func _on_Area2D_area_entered(area):
	EnemyStats.health -= area.damage


func _on_Stats_no_health():
	queue_free()


func _on_Range_body_entered(body):
	if body != null:
		player = body
		$Timer.one_shot = false
		

func _on_Range_body_exited(body):
	player = null
	
func fire():
	var bullet = Bullet.instance()
	bullet.position = get_global_position()
	bullet.player = player
	get_parent().add_child(bullet)
	$Timer.set_wait_time(1.5)

func _on_Timer_timeout():
	if player != null:
		fire()

