class_name Attack 


var amount : int
var color : String
var source : Node
var target : Node
var tint : Vector3

func hit():
	if source.has_method("land_attack"):
		source.land_attack(self)
	if target.has_method("take_attack"):
		target.take_attack(self)
	
