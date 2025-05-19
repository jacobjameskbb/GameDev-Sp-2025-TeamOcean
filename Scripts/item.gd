extends Control

var item_type: StringName

var cost: int

func _ready():
	$Label.text = str(item_type)
	
	$Cost.text = str(cost)


func _on_button_up():
	Global.buy_item(item_type, self)
