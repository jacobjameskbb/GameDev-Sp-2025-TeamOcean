extends Control


func _on_unpause_button_up():
	get_tree().paused = false
	self.queue_free()


func _on_quit_button_up():
	get_tree().paused = false
	Global.call_deferred(&"load_scene", &"00000000")
