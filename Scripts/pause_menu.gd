extends Control


func _on_unpause_button_up():
	get_tree().paused = false
	self.queue_free()


func _on_quit_button_up():
	Global.load_scene(&"00000000")


func _on_line_edit_text_submitted(new_text):
	if StringName(new_text) in Global.item_keys.keys():
		$LineEdit.release_focus()
		
		Global.give_item(StringName(new_text))
