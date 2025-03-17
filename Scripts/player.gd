extends CharacterBody2D

#movement variables
const GRAVITY = 2.5

const SPEED = 0.25

@export var terminal_velocity: int = 64

@export var jump_speed: int = 80

@export var seconds_per_gravity_increase: float = 1

var gravity_delay: float = seconds_per_gravity_increase / terminal_velocity

var initial_jump_height: float

var gravity_waiting = false

#animation variables
var gun_bounce = range(0,1)


func _physics_process(delta):
	if Input.is_action_just_released(&"Fire"):
		Global.make_bullet(self, (self.scale.x))
	
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
	print()
	print(self.scale)
	if Input.is_action_pressed(&"Left"):
		velocity.x += -1 * delta * 5000
		
		if self.scale.x != -1:
			print('ding')
			print(self.scale)
			self.scale.x = -1
			print(self.scale)
			print('ding')
	print(self.scale)
	if Input.is_action_pressed(&"Right"):
		velocity.x += 1 * delta * 5000
		
		if self.scale.x != 1:
			self.scale.x = 1
			print("dong")
	
	print(self.scale)
	move_and_slide()


func increase_gravity():
	gravity_waiting = true
	
	await get_tree().create_timer(gravity_delay).timeout
	
	gravity_waiting = false
	
	velocity.y += 1 * GRAVITY
