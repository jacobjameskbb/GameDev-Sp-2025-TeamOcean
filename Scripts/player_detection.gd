extends Area2D


func _ready():
	$CollisionShape2D.scale = get_viewport().size / 2


func _on_body_entered(body):
	if body.is_in_group(&"Player"):
		body.locked = self.global_position.x - get_viewport().size.x / 2
		get_parent().active = true
		print(body.locked)
