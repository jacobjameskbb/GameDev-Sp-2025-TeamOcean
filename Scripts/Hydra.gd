extends CharacterBody2D
var abilities = {"Explosive": true}
var stateKeys = {0:"idle", 1:"bShoot", 2:"Shoot", 3:"fShoot", 4:"impale", 5:"idle", 6:"idle", 7:"idle", 8:"idle", 9:"idle", 10:"idle", 11:"idle", 12:"idle", 13:"idle", 14:"idle", 15:"idle", 16:"idle"}
var active = true
var state = 0
var frame = 0
var countDownSecs = 0
var failAttack = 0
var Attack = 0
var reached = 0


func _ready():
	$impale.monitoring = false
	
	
func _process(delta):
	if active == true:
		if frame == 0:
			state = 0
			countDownSecs = 3
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
	if state == 0:
		failAttack += 1
		Attack = 0
	else:
		failAttack = 0
		Attack += 1
		
	
	if failAttack >= 8:
		state = randi_range(1, 4)
	elif Attack >= 2:
		state = 0
	else:
		state = randi_range(0, 4)
	print(state)
	print($AnimatedSprite2D.frame)
