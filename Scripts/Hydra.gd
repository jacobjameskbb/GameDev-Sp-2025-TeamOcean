extends CharacterBody2D

var abilities = {"Explosive": false}
var stateKeys = {
	0:"idle",
	1:"bShoot",
	2:"Shoot",
	3:"fShoot",
	4:"impale",
	5:"idle",
	6:"idle",
	7:"idle",
	8:"idle",
	9:"idle",
	10:"idle",
	11:"idle",
	12:"idle",
	13:"idle",
	14:"idle",
	15:"idle",
	16:"idle"}

var state = 0
var frame = 0
var countDownSecs = 0
var failAttack = 0
var Attack = 0
var reached = 0
var fire = load("res://Scenes/hydra_fire.tscn")
var health = 100
var target: Object
var stunned = false
var slowed = false


func _ready():
	$impale.monitoring = false


func _process(delta):
	if target != null and stunned == false:
		if frame == 0:
			state = 0
			if slowed == false:
				countDownSecs = 3
			else:
				countDownSecs = 5
			
		if reached == 0:
			countDownSecs -= 1 * delta
		
		
		$AnimatedSprite2D.play(stateKeys[state])
		
		
		if countDownSecs <= 0:
			state = 0
			reached = 1
			countDownSecs = 1
		if $AnimatedSprite2D.frame == 6:
			$impale.monitoring = true
		else:
			$impale.monitoring = true
		frame += 1


func _on_animated_sprite_2d_animation_finished():
	if stunned == false:
		if state == 0:
			failAttack += 1
			Attack = 0
		else:
			failAttack = 0
			Attack += 1
			
		
		if failAttack >= 32:
			state = randi_range(1, 4)
		elif Attack >= 2:
			state = 0
		else:
			state = randi_range(0, 16)
	else:
		state = 0
		
	if state == 1 or state == 2 or state == 3:
		var firei = fire.instantiate()
		firei.shooter = self
		if state == 1:
			firei.global_position = Vector2(self.global_position.x- 10, self.global_position.y - 25)
		if state == 2:
			firei.global_position = Vector2(self.global_position.x- 25, self.global_position.y - 24)
		if state == 3:
			firei.global_position = Vector2(self.global_position.x- 24, self.global_position.y -14)
		if target != null:
			firei.direction = -(firei.global_position - target.global_position + -0.25 * target.velocity * firei.global_position.distance_to(target.global_position) / 300).normalized()
		else:
			firei.direction = Vector2(-1, 0)
		get_parent().add_child(firei)


func damaged(dmg):
	if target != null:
		health -= dmg
		if health <= 0:
			queue_free()


func stun():
	stunned = true
	
	await get_tree().create_timer(1.5).timeout
	
	stunned = false


func slow():
	slowed = true
	
	await get_tree().create_timer(1).timeout
	
	slowed = false


func _on_impale_body_entered(body):
	if target != null:
		if body.is_in_group(&"Player"):
			body.damaged(5)


func _on_detection_body_entered(body):
	print("ding")
	if body.is_in_group(&"Player"):
		target = body
