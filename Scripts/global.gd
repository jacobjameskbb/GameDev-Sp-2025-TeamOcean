extends Node
#for example
#"ABCDEFGH" : 'res://Scenes/main.tscn',
var scene_keys: Dictionary = {
	&"00000000" : &"res://Scenes/ui.tscn",
	&"73824691" : &"res://Scenes/level_1.tscn",
}

var item_keys: Dictionary = {
	
}

#scenes path
var current_scene: StringName

func _physics_process(_delta):
	if Input.is_action_just_released(&"OpenMenu"):
		get_tree().paused = true
		place_pause_menu()


func place_pause_menu():
	var new_pause_menu = load("res://Scenes/pause_menu.tscn").instantiate()
	
	new_pause_menu.position = get_tree().get_first_node_in_group(&"Player").position - Vector2(288, 160)
	
	get_tree().current_scene.add_child(new_pause_menu)


func load_scene(key):
	if key not in scene_keys.keys():
		return
	
	current_scene = scene_keys[key]
	
	get_tree().change_scene_to_file(current_scene)


func give_item(item_key):
	item_key = 1


func make_bullet(bullet_owner: Object, bullet_direction):
	var bullet_scene = load("res://Scenes/bullet.tscn").instantiate()
	
	bullet_scene.shooter = bullet_owner
	
	bullet_scene.position = bullet_owner.position
	
	bullet_scene.direction = bullet_direction
	
	get_tree().current_scene.add_child(bullet_scene)
