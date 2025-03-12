extends Control

func _on_start_button_up():
	Global.load_scene("73824691")


func _on_load_button_up():
	$UI/MainMenu.hide()
	$UI/LoadGameMenu.show()


func _on_quit_button_up():
	get_tree().quit()


func _on_load_back_button_up():
	$UI/LoadGameMenu.hide()
	$UI/MainMenu.show()


func _on_load_start_button_up():
	Global.load_scene($UI/LoadGameMenu/LineEdit.text)
