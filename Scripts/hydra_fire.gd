extends Node2D

var damage: int = 1

var shooter: Object

var direction = 1

const SPEED = 500

func _ready():
	pass


func _physics_process(delta):
	self.position += SPEED * delta * direction


func _on_area_2d_body_entered(body):
	if body != shooter:
		if body.is_in_group(&"Player"):
			body.damaged(damage)
		
		if shooter.abilities[&"Explosive"] == true:
			Global.call_deferred(&"make_explosion", self.position)
		
		queue_free()
