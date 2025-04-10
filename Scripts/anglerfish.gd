extends CharacterBody2D


var speed = 64

var health = 1

var damage: float = 0.25

var target: Object = self

var target_in_area: bool = false

var can_attack: bool = true

var attack_cooldown: float = 0.5


func _physics_process(_delta):
	move()
	
	$AnimatedSprite2D.play("walk")
	
	if target_in_area and can_attack:
		attack()


func death():
	Global.enemy_death(&"Anglerfish", self.position)
	
	call_deferred(&"queue_free")


func damaged(damage_amount):
	health += -1 * damage_amount
	
	if health <= 0:
		death()


func move():
	if self.global_position.x - target.global_position.x >= 13.5 or self.global_position.x - target.global_position.x <= -13.5:
		velocity.x = speed * (target.global_position.x - self.global_position.x) / abs(target.global_position.x - self.global_position.x)
		if target.global_position.x > self.global_position.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = 0
	if self.global_position.y - target.global_position.y >= 13.5 or self.global_position.y - target.global_position.y <= -13.5:
		velocity.y = speed / 3 * (target.global_position.y - self.global_position.y) / abs(target.global_position.y - self.global_position.y)
	else:
		velocity.y = 0
	
	move_and_slide()


func attack():
	can_attack = false
	
	await get_tree().create_timer(attack_cooldown).timeout
	
	can_attack = true
	
	if target.has_method(&"damage") and target_in_area == true:
		target.damage()


func _on_detect_body_entered(body):
	if body.is_in_group(&"Player"):
		target = body


func _on_detect_body_exited(body):
	if body == target:
		target = self


func _on_kill_body_entered(body):
	if body.is_in_group(&"Player"):
		target_in_area = true


func _on_kill_body_exited(body):
	if body == target:
		target_in_area = false
