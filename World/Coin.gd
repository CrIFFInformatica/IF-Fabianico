extends Area2D



func _on_Coin_body_entered(body):
	self.queue_free()
