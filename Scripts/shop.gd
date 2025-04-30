extends Node

@export var loot_level: int = 1

@onready var container = $ShopInterface/ScrollContainer/VBoxContainer

# The contents of the lists in the dictionary should be StringNames
const loot_dictionary = {
	1 : [&"Stun", &"Explosive"],
	2 : [],
	3 : [],
	4 : [],
}



func _ready():
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
	pass # Replace with function body.


func open_shop():
	pass
	
	
	
	
	
