extends KinematicBody2D

var velocity = Vector2()
var direction = -1
var Player_damage = 1

onready var stats = $Stats



signal MeleeDead

func _physics_process(delta):
	
	$Control/Label.text = str(stats.health)
	
	if is_on_wall() or not $RayCast2D.is_colliding():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	$RayCast2D.position.x = 20 * direction
	$Hitbox.position.x = 20 * direction
	velocity.y += 20
	velocity.x = 15 * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage


func _on_Stats_no_health():
	queue_free()
	


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("MeleeDead")
