extends Node2D

@export var destination: StringName

@export var position_offset: Vector2

var target_starting_position: Vector2

var target


func _process(_delta):
	if target != null:
		target.position = target_starting_position + position_offset


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		self.change_scene(body)


func change_scene(body: Object):
	if destination != &"":
		target = body
		target_starting_position = body.position
		$AnimationPlayer.play("flowing_current")
	else:
		printerr("NO PATH")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "flowing_current":
		Global.call_deferred(&"load_scene", destination)
