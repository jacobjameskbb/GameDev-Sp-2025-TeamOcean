extends CharacterBody2D

var locked = null

var health = 3

var max_health = 3

var abilities = {
	&"Stun" : false,
	&"Explosive" : false,
	&"Slow" : false,
	&"Auto" : false,
	&"Health" : 0,
}

var gun_cooldown: float = 0.5

var preparing_gun = false

var gun_position: Vector2

var pearls_label: Object

#movement variables
const GRAVITY = 2.5

@export var speed = 4

@export var terminal_velocity: int = 48

@export var jump_speed: int = 76

@export var seconds_per_gravity_increase: float = 0.9

var gravity_delay: float = seconds_per_gravity_increase / terminal_velocity

var initial_jump_height: float

var gravity_waiting = false

#animation variables
const bounce_limit = 0.5

var flipped = 1

var hit_lower_range = false

var bounce_delay = 0.5

var health_control: Object


func _ready():
	$Pearls/PearlsLabel.text = str(Global.pearls)
	
	health_control = $HealthControl
	
	health_control.health = health
	
	pearls_label = $Pearls/PearlsLabel
	
	abilities = Global.abilities


func adjust_health():
	if max_health != max_health + abilities[&"Health"]:
		max_health += 1
		health += 1
	
	health_control.health = health


func _process(_delta):
	if locked != null:
		if global_position.x < locked:
			global_position.x = locked
		elif global_position.x > locked + get_viewport().size.x:
			global_position.x = locked + get_viewport().size.x


func _physics_process(delta):
	if hit_lower_range == false:
		$Gun.position.y += 0.01
	else:
		$Gun.position.y += -0.01
	
	if $Gun.position.y >= bounce_limit or $Gun.position.y <= -bounce_limit:
		hit_lower_range = not hit_lower_range
	
	gun_position = $Gun.position
	
	if Input.is_action_just_released(&"Fire") and preparing_gun == false and Global.mouse_in_menu == false:
		fire_bullet()
	
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
		$AnimatedSprite2D.play(&"walking")
		
		if SoundBus.playing_sound(&"Walk") == false and is_on_floor():
			SoundBus.play_sound(&"Walk")
		
		velocity.x += -1 * delta * speed * 1000
		
		if self.flipped == 1 and Input.is_action_pressed(&"Right") == false:
			self.scale.x = -1
			self.flipped = -1
			$Pearls.scale.x = -1
			health_control.scale.x = -1
			health_control.position.x += 560
	
	if Input.is_action_pressed(&"Right"):
		$AnimatedSprite2D.play(&"walking")
		
		if SoundBus.playing_sound(&"Walk") == false and is_on_floor():
			SoundBus.play_sound(&"Walk")
		
		velocity.x += 1 * delta * speed * 1000
		
		if self.flipped == -1 and Input.is_action_pressed(&"Left") == false:
			self.scale.x = -1
			self.flipped = 1
			$Pearls.scale.x = 1
			health_control.scale.x = 1
			health_control.position.x -= 560
	
	if Input.is_action_pressed(&"Right") == false and Input.is_action_pressed(&"Left") == false:
		$AnimatedSprite2D.play(&"default")
	
	move_and_slide()


func fire_bullet():
	Global.make_bullet(self, (flipped))
	
	preparing_gun = true
	
	if abilities[&"Auto"] == true and gun_cooldown != 0.1:
		gun_cooldown = 0.1
	
	await get_tree().create_timer(gun_cooldown).timeout
	
	preparing_gun = false


func increase_gravity():
	gravity_waiting = true
	
	await get_tree().create_timer(gravity_delay).timeout
	
	gravity_waiting = false
	
	velocity.y += 1 * GRAVITY


func damaged(damage_amount := 1):
	health -= 1 * damage_amount
	
	health_control.health = health
	
	if health < 1:
		SoundBus.play_sound(&"Loser")
		Global.call_deferred(&"load_scene", &"00000000")


func increase_pearls(amount = 1):
	Global.pearls += amount
	
	$Pearls/PearlsLabel.text = str(Global.pearls)
