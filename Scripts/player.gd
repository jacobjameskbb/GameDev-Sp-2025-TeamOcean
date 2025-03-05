extends CharacterBody2D

const GRAVITY = 2

const SPEED = 1

@export var terminal_velocity = 64

@export var jump_speed = 32

@export var max_jump_height = 32

var jumping = false

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
			if velocity.y < terminal_velocity:
				#if velocity.y < 0:
				#	velocity.y /= 2
				velocity.y += 1 * GRAVITY
	
	if Input.is_action_pressed(&"Left"):
		velocity.x += -1 * delta * 5000
	
	if Input.is_action_pressed(&"Right"):
		velocity.x += 1 * delta * 5000
	
	move_and_slide()
