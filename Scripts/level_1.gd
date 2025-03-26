extends Node




func _on_end_body_entered(body):
	if body.is_in_group(&"Player"):
		Global.load_scene("19285564")
	print("ding")
