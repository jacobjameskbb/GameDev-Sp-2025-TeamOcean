extends Area2D


func _ready():
	$CollisionShape2D.scale = get_viewport().size / 2


func body_entered(body):
	if body.is_in_group(&"Player"):
		body.locked = self.global_position - get_viewport().size.x / 2
		get_parent().active = true
