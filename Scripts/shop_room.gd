extends Node

@export var destination: StringName

@export var loot_level: int

func _ready():
	await get_tree().create_timer(1).timeout
	print("ding")
	$Current.destination = destination
	
	$Shop.loot_level = loot_level

