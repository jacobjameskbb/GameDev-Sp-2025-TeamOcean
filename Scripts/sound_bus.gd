extends Node


func play_sound(sound: StringName):
	for node in get_children():
		if node.name == sound:
			node.play()


func playing_sound(sound: StringName):
	for node in get_children():
		if node.name == sound:
			return node.is_playing()
