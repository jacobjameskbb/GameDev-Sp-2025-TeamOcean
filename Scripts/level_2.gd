extends Node



func _on_end_body_entered(body):
	if body.is_in_group(&"Player"):
		Global.call_deferred(&"load_scene", &"19191919")
