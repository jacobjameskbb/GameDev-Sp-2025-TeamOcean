extends CharacterBody2D

const GRAVITY = 2

const SPEED = 1

@export var terminal_velocity: int = 48

@export var jump_speed: int = 64

@export var seconds_per_gravity_increase: float = 1

var gravity_delay: float = seconds_per_gravity_increase / terminal_velocity

var initial_jump_height: float

var gravity_waiting = false


func _physics_process(delta):
	velocity.x = 0
	
	if is_on_floor():
		if velocity.y > 0:
			velocity.y = 0
		
		if Input.is_action_just_pressed(&"Jump"):
			initial_jump_height = position.y
			velocity += Vector2(0, -1 * jump_speed)
	
	else:
		if velocity.y < terminal_velocity and gravity_waiting == false:
			increase_gravity()
	
	if Input.is_action_pressed(&"Left"):
		velocity.x += -1 * delta * 5000
	
	if Input.is_action_pressed(&"Right"):
		velocity.x += 1 * delta * 5000
	
	move_and_slide()


func increase_gravity():
	gravity_waiting = true
	
	await get_tree().create_timer(gravity_delay).timeout
	
	gravity_waiting = false
	
	velocity.y += 1 * GRAVITY
