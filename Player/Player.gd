extends KinematicBody2D

var ACCELERATION = 512
var GRAVITY = 270
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
var MAXSPEED = 64
const JUMPFORCE = 135

var motion = Vector2.ZERO
var snap = Vector2.DOWN setget set_snap_normal
export var stamina = 100.0
var max_stamina = 100
var is_dashing = false
var is_jumping = false
var is_attacking = false
var is_doublejumping = false
var body = null
export var player_health = 4
var coxinha = 0
var coquinha = 0
var almoco = 0
var iten4 = false

signal player_dead

onready var sprite = $Sprite
onready var animationplayer = $AnimationPlayer
onready var Hitbox = $Hitbox/CollisionShape2D
onready var abilities = $"DoubleJump"
onready var dash = $Dash
onready var Player_damage = $Hitbox


func _ready():
	abilities.set_wait_time(1)

func _physics_process(delta):
	
	if coxinha != 0 or coquinha != 0 or almoco != 0:
		$Control/Panel.visible = true
		$Control/Panel/Label.text = str("Coxinha:", coxinha)
		$Control/Panel/Label2.text = str("Coquinha:", coquinha)
		$Control/Panel/Label3.text = str("Almoço:", almoco)
	else:
		$Control/Panel.visible = false
	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	$TextureRect.rect_size.x = stamina * 0.2
	$Control/Label.text = str(player_health)
	
	if Input.is_action_just_pressed("Coxinha"):
		if player_health < 4:
			if coxinha > 0:
				player_health = player_health + 1 
				coxinha = coxinha - 1
	if Input.is_action_just_pressed("Coquinha"):
		if player_health < 2:
			if coxinha > 0:
				player_health = player_health + 2
				coquinha = coquinha - 1
	if Input.is_action_just_pressed("Almoco"):
		if player_health < 4:
			if almoco > 0:
				Player_damage.damage = Player_damage.damage + 1
				if iten4 == false:
					player_health = player_health + (5 - player_health)
				if iten4 == true:
					player_health = player_health + (6 - player_health)
				almoco = almoco - 1


		
	if stamina > 50:
		if Input.is_action_just_pressed("dash"):
			is_dashing = true
			animationplayer.play("Dashing")
			MAXSPEED = MAXSPEED + 150
			ACCELERATION = 1000
			dash.start(0.5)
			abilities.start()
			stamina = stamina - 50
			
			
	
	if x_input != 0: #Está se mexendo
		if is_dashing == false and is_jumping == false and is_attacking == false:
			animationplayer.play("Moving")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
		sprite.flip_h = x_input < 0
		if x_input < 0: #Está se mexendo para a Esquerda
			Hitbox.position = Vector2(-15, 0)
		else: #Está se mexendo para a Direita
			Hitbox.position = Vector2(15,0)
	elif is_dashing == false and is_jumping == false and is_attacking == false: #Está parado
		animationplayer.play("Idle")
	
	if Input.is_action_just_pressed("Attack "):
		animationplayer.play("Attacking")
		is_attacking = true
		
		

	if is_on_floor() == true: #Está no chão
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		if Input.is_action_just_pressed("up"):
			is_jumping = true
			is_attacking = false
			$Hitbox/CollisionShape2D.disabled = true
			animationplayer.play("Jumping")
			snap = Vector2(0, 0)
			motion.y = -JUMPFORCE
		
	else: #Está no Ar
		if stamina != 100:
			if Input.is_action_just_released("up") and motion.y < -JUMPFORCE/2:
				is_doublejumping = true
				is_jumping = true
				is_attacking = false
				is_dashing = false
				motion.y = -JUMPFORCE/2
				animationplayer.play("Jumping")
				snap = Vector2.DOWN
			else:
				is_doublejumping = false
			if x_input == 0:
				motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
		if stamina >= 100:
			if Input.is_action_just_pressed("up"):
				motion.y = -JUMPFORCE
				animationplayer.play("Jumping")
				stamina = 0
				abilities.start()
	
	motion.y += GRAVITY * delta
	motion = move_and_slide_with_snap(motion, snap * 2, Vector2.UP)
	
func set_snap_normal(new_snap):
	snap = new_snap

func _on_Double_Jump_and_Dash_timeout():
	stamina = stamina + 5
	if stamina == max_stamina:
		abilities.stop()



func _on_Dash_timeout():
	ACCELERATION = 512
	MAXSPEED = 64
	dash.stop()
	is_dashing = false


func _on_Chest_Iten1():
	print ("ITEM 1")
	MAXSPEED = 100


func _on_Chest_Iten2():
	print ("ITEM 2")
	stamina = 150
	max_stamina = 150


func _on_Chest_Iten4():
	print ("ITEM 4")
	player_health += 1
	iten4 = true

func _on_Hurtbox_area_entered(area):
	player_health = player_health - 1
	if player_health == 0:
		queue_free()
		emit_signal("player_dead")


func _on_Chest_Iten3():
	print("ITEM 3")
	Player_damage.damage = 2


func _on_Hurtbox_body_entered(body):
	player_health = player_health - 1
	if player_health == 0:
		queue_free()
		emit_signal("player_dead")


func _on_AnimationPlayer_animation_finished(anin_name):
	if anin_name == "Attacking":
		is_attacking = false
	if anin_name == "Jumping":
		if is_doublejumping == false:
			is_jumping = false
	if anin_name == "Dashing":
		is_dashing = false


func _on_World_Next_phase():
	if iten4 == false:
		player_health = 5
	if iten4 == true:
		player_health = 6
	position.x = 2600
	position.y = -150


func _on_World_ItensCantinaAlm():
	almoco = almoco + 1


func _on_World_ItensCantinaCoq():
	coquinha = coquinha + 1


func _on_World_ItensCantinaCox():
	coxinha = coxinha + 1


func _on_World2_finished():
	$Hurtbox/CollisionShape2D.disabled = true
