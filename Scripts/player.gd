extends CharacterBody2D

const GRAVITY = 1

const JUMPSPEED = 1

@export var max_jump_height = 1



func _process(_delta):
	pass


func _physics_process(_delta):
	if is_on_floor():
		if velocity.y > 0:
			velocity.y = 0
		
		if Input.is_action_just_pressed(&"Jump"):
			velocity += Vector2(0, -1 * JUMPSPEED)
	
	
	
	
	move_and_slide()
