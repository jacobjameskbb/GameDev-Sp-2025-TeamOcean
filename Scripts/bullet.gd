extends Node2D

var damage: int = 1

var shooter: Object

var direction = 1

const SPEED = 500

func _ready():
	if direction == -1:
		$Sprite2D.flip_h = true


func _physics_process(delta):
	self.position += self.transform.x * SPEED * delta * direction


func _on_area_2d_body_entered(body):
	if body != shooter:
		if body.is_in_group(&"Enemy"):
			body.health += -damage
		
		queue_free()
