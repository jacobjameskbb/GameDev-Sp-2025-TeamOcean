extends Node2D

@export var destination: StringName


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		_change_scene()


func _change_scene():
	if destination != &"":
		Global.call_deferred(&"load_scene", destination)
	else:
		printerr("NO PATH")

