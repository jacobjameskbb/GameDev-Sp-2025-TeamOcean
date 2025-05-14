extends Control

var health = 3

var list_of_health_points: Array


func _process(_delta):
	if list_of_health_points.size() < health:
		make_health_sprite()
	
	if list_of_health_points.size() > health:
		remove_health_sprite()


func make_health_sprite():
	var new_sprite = TextureRect.new()
	
	new_sprite.texture = load(&"res://Sprites/PlayerHealthPoint.png")
	
	list_of_health_points.append(new_sprite)
	
	$HBoxContainer.add_child(new_sprite)


func remove_health_sprite():
	var sprite_removing = list_of_health_points.back()
	
	list_of_health_points.erase(sprite_removing)
	
	sprite_removing.queue_free()
