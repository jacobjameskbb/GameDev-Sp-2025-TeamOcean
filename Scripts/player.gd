extends CharacterBody2D
var health = 3
#movement variables
const GRAVITY = 2.5

const SPEED = 4

@export var terminal_velocity: int = 48

@export var jump_speed: int = 76

@export var seconds_per_gravity_increase: float = 0.9

var gravity_delay: float = seconds_per_gravity_increase / terminal_velocity

var initial_jump_height: float

var gravity_waiting = false

#animation variables
var gun_bounce = range(0,1)

var flipped = 1

func _physics_process(delta):
	if Input.is_action_just_released(&"Fire"):
		Global.make_bullet(self, (flipped))
	
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
		$AnimatedSprite2D.play("walking")
		velocity.x += -1 * delta * SPEED * 1000
		
		if self.flipped == 1 and Input.is_action_pressed(&"Right") == false:
			self.scale.x = -1
			self.flipped = -1
	
	if Input.is_action_pressed(&"Right"):
		$AnimatedSprite2D.play("walking")
		velocity.x += 1 * delta * SPEED * 1000
		
		if self.flipped == -1 and Input.is_action_pressed(&"Left") == false:
			self.scale.x = -1
			self.flipped = 1
	
	if Input.is_action_pressed(&"Right") == false and Input.is_action_pressed(&"Left") == false:
		$AnimatedSprite2D.play("default")
	
	move_and_slide()


func increase_gravity():
	gravity_waiting = true
	
	await get_tree().create_timer(gravity_delay).timeout
	
	gravity_waiting = false
	
	velocity.y += 1 * GRAVITY


func damage(damage_amount := 1):
	health -= 1 * damage_amount
	if health < 1:
		Global.load_scene(&"00000000")
