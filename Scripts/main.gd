extends Node

#for example
#"ABCDEFGH" : preload('res://Scenes/main.tscn'),
@onready var scene_keys: Dictionary = {
	"73824691" : preload("res://Scenes/level_1.tscn")
}

var current_level: Node = null

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
	load_scene($UI/LoadGameMenu/LineEdit.text)


func load_scene(key):
	if key not in scene_keys.keys():
		return
	
	if current_level != null:
		current_level.queue_free()
	
	current_level = scene_keys[key].instantiate()
	
	self.add_child(current_level)
