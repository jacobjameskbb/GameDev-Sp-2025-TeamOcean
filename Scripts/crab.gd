extends CharacterBody2D

# Crab Statistics
var speed = 48

var health = 2

var stunned = false

# Crab Combat
var damage: float = 1

var target: Object = self

var target_in_area: bool = false

var can_attack: bool = true

var attack_cooldown: float = 0.5


func _physics_process(_delta):
	if stunned == false:
		move()
	
	if target_in_area and can_attack and stunned == false:
		attack()


func death():
	Global.enemy_death(&"Crab", self.position)
	
	call_deferred(&"queue_free")


func damaged(damage_amount):
	health += -1 * damage_amount
	
	if health <= 0:
		death()


func move():
	if self.global_position.x - target.global_position.x >= 13.5 or self.global_position.x - target.global_position.x <= -13.5:
		velocity.x = 24 * (target.global_position.x - self.global_position.x) / abs(target.global_position.x - self.global_position.x)
	else:
		velocity.x = 0
	
	if is_on_floor() == false:
		velocity.y += 2
	
	move_and_slide()


func attack():
	can_attack = false
	
	await get_tree().create_timer(attack_cooldown).timeout
	
	SoundBus.play_sound(&"Crunch")
	
	can_attack = true
	
	if target.has_method(&"damaged") and target_in_area == true:
		target.damaged()


func stun():
	self.stunned = true
	
	await get_tree().create_timer(1.5).timeout
	
	self.stunned = false


func slow():
	speed /= 2
	
	await get_tree().create_timer(1).timeout
	
	speed *= 2


func _on_area_2d_body_entered(body):
	if body.is_in_group(&"Player"):
		target = body


func _on_area_2d_body_exited(body):
	if body == target:
		target = self


func _on_kill_body_entered(body):
	if body.is_in_group(&"Player"):
		target_in_area = true


func _on_kill_body_exited(body):
	if body == target:
		target_in_area = false
