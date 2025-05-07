extends Node2D

func _on_area_2d_body_entered(body):
	if body.is_in_group(&"Player"):
		body.increase_pearls()
		
		SoundBus.play_sound(&"Coin1")
		
		self.queue_free()
