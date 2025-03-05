extends Node

#for example
#"ABCDEFGH" : preload('res://Scenes/main.tscn'),
@onready var scene_keys: Dictionary = {
	
}



func _on_start_button_up():
	pass


func _on_load_button_up():
	$UI/MainMenu.hide()
	$UI/LoadGameMenu.show()


func _on_quit_button_up():
	get_tree().quit()


func _on_load_back_button_up():
	$UI/LoadGameMenu.hide()
	$UI/MainMenu.show()


func _on_load_start_button_up():
	pass # Replace with function body.


func load_scene(key):
	
	
	
	pass
