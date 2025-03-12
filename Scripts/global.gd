extends Node
#for example
#"ABCDEFGH" : 'res://Scenes/main.tscn',
@onready var scene_keys: Dictionary = {
	&"73824691" : &"res://Scenes/level_1.tscn"
}

var current_scene: StringName


func load_scene(key):
	if key not in scene_keys.keys():
		return
	
	current_scene = scene_keys[key]
	
	get_tree().change_scene_to_file(current_scene)
