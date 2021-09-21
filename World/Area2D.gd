extends Area2D

var iten_rng = RandomNumberGenerator.new()
var chest_empty = false

onready var closed = $Sprite
onready var open = $Sprite2

signal Iten1
signal Iten2
signal Iten3
signal Iten4

func _ready():
	closed.visible = true
	open.visible = false

func _on_Area2D_area_entered(area):
	if chest_empty == false:
		iten_rng.randomize()
		closed.visible = false
		open.visible = true
		var iten = iten_rng.randi_range(1, 4)
		if iten == 1:
			emit_signal("Iten1")
		if iten == 2:
			emit_signal("Iten2")
		if iten == 3:
			emit_signal("Iten3")
		if iten == 4:
			emit_signal("Iten4")
		chest_empty = true
	
