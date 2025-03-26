extends CharacterBody2D

var target: Object = self
var speed = 48
var health = 1

func _physics_process(_delta):
	move()
	
	if health < 1:
		queue_free()
		


func move():
	if not target.global_position.x - self.global_position.x == 0:
		velocity.x = 24 * (target.global_position.x - self.global_position.x) / abs(target.global_position.x - self.global_position.x)
	else:
		velocity.x = 0
	
	velocity.y += 2
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group(&"Player"):
		target = body


func _on_area_2d_body_exited(body):
	if body.is_in_group(&"Player"):
		target = self


func _on_kill_body_entered(body):
	if body.is_in_group(&"Player"):
		body.damage()
		print(body.health)
