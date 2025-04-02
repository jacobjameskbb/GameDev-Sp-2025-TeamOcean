extends Node2D

var victims := []


func _ready():
	$AnimatedSprite2D.play(&"default")


func _process(_delta):
	
	for body in $Area2D.get_overlapping_bodies():
		if body.has_method(&"damaged") and body not in victims:
			victims.append(body)
			body.damaged(5)


func _on_animated_sprite_2d_animation_finished():
	self.queue_free()
