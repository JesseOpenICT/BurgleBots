extends Node

var speedmodifyer = 0.5

func _ready():
	get_parent().update_speed()

func update_speed(speed, recovery):
	return [speed*speedmodifyer , recovery]

func drop():
	speedmodifyer = 1
	get_parent().update_speed()
	get_parent().abilities.erase(self)
	queue_free()
	
