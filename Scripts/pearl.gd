extends Node2D

func _on_area_2d_body_entered(body):
	if body.is_in_group(&"Player"):
		Global.pearls += 1
		
		self.queue_free()
