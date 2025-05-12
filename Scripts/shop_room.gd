extends Node

@export var destination: StringName

@export var shop_level: int

func _ready():
	$Current.destination = destination
	
	$Shop.loot_level = shop_level

