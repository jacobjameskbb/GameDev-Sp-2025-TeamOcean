extends CharacterBody2D
var abilities = {"Explosive": false}
var stateKeys = {0:"idle", 1:"bShoot", 2:"Shoot", 3:"fShoot", 4:"impale", 5:"idle", 6:"idle", 7:"idle", 8:"idle", 9:"idle", 10:"idle", 11:"idle", 12:"idle", 13:"idle", 14:"idle", 15:"idle", 16:"idle"}
var active = false
var state = 0
var frame = 0
var countDownSecs = 0
var failAttack = 0
var Attack = 0
var reached = 0
var fire = load("res://Scenes/hydra_fire.tscn")
var health = 100


func _ready():
	$impale.monitoring = false
	


func _process(delta):
	if active == true:
		if frame == 0:
			state = 0
			countDownSecs = 3
		if reached == 0:
			countDownSecs -= 1 * delta
		
		
		if global_position.distance_to(get_parent().player.global_position) > 150:
			$Label.visible = true
		else:
			$Label.visible = false
		
		
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
		if state != 0:
			state = randi_range(0, 16)
			if state != 0:
				state = randi_range(0, 16)
				
				
	print(state)
	print($AnimatedSprite2D.frame)
	if state == 1 or state == 2 or state == 3:
		var firei = fire.instantiate()
		firei.shooter = self
		if state == 1:
			firei.global_position = Vector2(self.global_position.x- 10, self.global_position.y - 25)
		if state == 2:
			firei.global_position = Vector2(self.global_position.x- 25, self.global_position.y - 24)
		if state == 3:
			firei.global_position = Vector2(self.global_position.x- 24, self.global_position.y -14)
		if get_parent().is_in_group(&"Enemy") == false and get_parent().has_signal("level") == true:
			firei.direction = -(firei.global_position - get_parent().player.global_position + -0.25 * get_parent().player.velocity * firei.global_position.distance_to(get_parent().player.global_position) / 300).normalized()
		else:
			firei.direction = Vector2(-1, 0)
		get_parent().add_child(firei)


func damaged(dmg):
	if not global_position.distance_to(get_parent().player.global_position) >= 150:
		health -= dmg
		print("ding")
		if health <= 0:
			queue_free()


func _on_impale_body_entered(body):
	if body.is_in_group(&"Player"):
		body.damaged(5)
