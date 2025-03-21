extends Control


func _on_unpause_button_up():
	get_tree().paused = false


func _on_quit_button_up():
	Global.load_scene(&"00000000")
