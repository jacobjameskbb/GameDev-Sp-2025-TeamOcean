extends Node

@export var destination: StringName

@export var loot_level: int

func _ready():
	$Current.destination = destination
	
	$Shop.loot_level = loot_level

