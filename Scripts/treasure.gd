extends Node2D

var target

@export var amount: int = 5

func _on_area_2d_body_entered(body):
	if body.is_in_group(&"Player"):
		target = body
		$AnimatedSprite2D.play(&"opening")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == &"opening":
		SoundBus.play_sound(&"Coin1")
		
		target.increase_pearls(amount)
		
		self.queue_free()
