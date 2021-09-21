extends KinematicBody2D

var move = Vector2.ZERO
var direction_vec = Vector2.ZERO
var player = null
var speed = 3


func _ready():
	direction_vec = player.position - global_position
	
func _physics_process(delta):
	move = Vector2.ZERO
	
	move = move.move_toward(direction_vec, delta)
	move = move.normalized() * speed
	position += move
	
