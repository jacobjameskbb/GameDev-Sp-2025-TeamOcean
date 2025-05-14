extends Node2D

@export var loot_level: int

@onready var container = $ShopInterface/ScrollContainer/VBoxContainer

# The contents of the lists in the dictionary should be StringNames
const loot_dictionary = {
	1 : [&"Stun", &"Slow", &"Health"],
	2 : [&"Explosive", &"Auto", &"Health"],
}


func _ready():
	await get_tree().process_frame
	
	if int(loot_level) in loot_dictionary.keys():
		for item in loot_dictionary[loot_level]:
			place_item(item)
	else:
		print(loot_level)
		
		loot_level = 1
		
		for item in loot_dictionary[loot_level]:
			place_item(item)


func place_item(item):
	var new_sellable_item = load("res://Scenes/item.tscn").instantiate()
	
	new_sellable_item.item_type = item
	
	new_sellable_item.cost = Global.item_cost[item]
	
	container.add_child(new_sellable_item)


func _on_area_2d_body_entered(body):
	if body.is_in_group(&"Player"):
		open_shop()


func _on_area_2d_body_exited(body):
	if body.is_in_group(&"Player"):
		close_shop()


func open_shop():
	$ShopInterface.visible = true


func close_shop():
	$ShopInterface.visible = false


func _on_shop_interface_mouse_entered():
	Global.mouse_in_menu = true


func _on_shop_interface_mouse_exited():
	Global.mouse_in_menu = false
