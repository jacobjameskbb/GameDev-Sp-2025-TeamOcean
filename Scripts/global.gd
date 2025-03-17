extends Node
#for example
#"ABCDEFGH" : 'res://Scenes/main.tscn',
@onready var scene_keys: Dictionary = {
	&"73824691" : &"res://Scenes/level_1.tscn"
}

#scenes path
var current_scene: StringName


func load_scene(key):
	if key not in scene_keys.keys():
		return
	
	current_scene = scene_keys[key]
	
	get_tree().change_scene_to_file(current_scene)


func make_bullet(bullet_owner: Object, bullet_direction):
	var bullet_scene = load("res://Scenes/bullet.tscn").instantiate()
	
	bullet_scene.shooter = bullet_owner
	
	bullet_scene.position = bullet_owner.position
	
	bullet_scene.direction = bullet_direction
	
	get_tree().current_scene.add_child(bullet_scene)
