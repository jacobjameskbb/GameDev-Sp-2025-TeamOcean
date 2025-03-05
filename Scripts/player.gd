extends CharacterBody2D

const GRAVITY = 2

const TERMINALVELOCITY = 64

const SPEED = 1

var jump_speed = 32

var jumping = false

@export var max_jump_height = 33

var initial_jump_height: float


func _process(_delta):
	pass


func _physics_process(delta):
	velocity.x = 0
	print(velocity)
	if is_on_floor():
		if velocity.y > 0:
			velocity.y = 0
		
		if Input.is_action_just_pressed(&"Jump"):
			initial_jump_height = position.y
			velocity += Vector2(0, -1 * jump_speed)
			jumping = true
	
	else:
		if position.y <= initial_jump_height - max_jump_height and jumping == true:
			print('ding')
			jumping = false
		
		if jumping == false:
			if velocity.y < TERMINALVELOCITY:
				if velocity.y < 0:
					velocity.y = 0
				velocity.y += 1 * GRAVITY
	
	if Input.is_action_pressed(&"Left"):
		velocity.x += -1 * delta * 5000
	
	if Input.is_action_pressed(&"Right"):
		velocity.x += 1 * delta * 5000
	
	move_and_slide()
