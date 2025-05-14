extends Node


func _on_button_button_up():
	get_tree().quit()


func _on_button_2_button_up():
	get_tree().change_scene_to_file("res://Scenes/level_5.tscn")


func _on_button_3_button_up():
	get_tree().change_scene_to_file("res://Scenes/LevelDaniel.tscn")


func _on_restart_button_up():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_button_4_button_up():
	get_tree().change_scene_to_file("res://Scenes/level_easton.tscn")
