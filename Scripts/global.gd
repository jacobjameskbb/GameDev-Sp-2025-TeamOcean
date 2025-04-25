extends Node
#for example
#"ABCDEFGH" : 'res://Scenes/main.tscn',
var scene_keys: Dictionary = {
	&"00000000" : &"res://Scenes/ui.tscn",
	&"73824691" : &"res://Scenes/level_1.tscn",
	&"19285564" : &"res://Scenes/level_2.tscn",
	&"19191919" : &"res://Scenes/level_3.tscn",
}

var item_keys: Dictionary = {
	&"72364581" : &"Stun",
	&"36810972" : &"Explosive",
}

#item cost in pearls
var item_cost: Dictionary = {
	&"Stun" : 12,
	&"Explosive" : 20,
	
	
}


#scene path
var current_scene: StringName

var loot_table = {
	&"Crab" : {
		&"Loot" : [&"Pearl"],
	},
	&"Anglerfish" : {
		&"Loot" : [&"Pearl"],
	},
}

var pearls: int = 0


func _physics_process(_delta):
	if Input.is_action_just_released(&"OpenMenu") and get_tree().get_first_node_in_group(&"Player") != null:
		get_tree().paused = true
		place_pause_menu()


func place_pause_menu():
	var new_pause_menu = load(&"res://Scenes/pause_menu.tscn").instantiate()
	
	new_pause_menu.position = get_tree().get_first_node_in_group(&"Player").position - Vector2(288, 160)
	
	get_tree().current_scene.add_child(new_pause_menu)


func load_scene(key):
	if key not in scene_keys.keys():
		return
	
	current_scene = scene_keys[key]
	
	get_tree().change_scene_to_file(current_scene)


func buy_item(item_key):
	if pearls >= item_cost[item_key]:
		pearls += -item_cost[item_key]
		
		give_item(item_key)


func give_item(item_key):
	get_tree().get_first_node_in_group(&"Player").abilities[item_key] = true


func enemy_death(type: StringName, position: Vector2):
	var loot: Array = loot_table[type][&"Loot"]
	
	var loot_picked: StringName
	
	if loot.size() > 1:
		loot_picked = loot.pick_random()
	else:
		loot_picked = loot[0]
	
	if loot_picked == &"Pearl":
		place_pearl(position)


func place_pearl(position: Vector2):
	var new_pearl = load("res://Scenes/pearl.tscn").instantiate()
	
	new_pearl.position = position
	
	get_tree().current_scene.call_deferred(&"add_child", new_pearl)


func make_explosion(position: Vector2):
	var new_explosion = load("res://Scenes/explosion.tscn").instantiate()
	
	new_explosion.position = position
	
	get_tree().current_scene.add_child(new_explosion)


func make_bullet(bullet_owner: Object, bullet_direction):
	var bullet_scene = load("res://Scenes/bullet.tscn").instantiate()
	
	bullet_scene.shooter = bullet_owner
	
	bullet_scene.position = bullet_owner.position
	
	bullet_scene.direction = bullet_direction
	
	get_tree().current_scene.add_child(bullet_scene)
