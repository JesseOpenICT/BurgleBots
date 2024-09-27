extends Button

@export var FUNCTION : String
@export var PARAM : Array[String]

func _on_pressed():
	var callable = Callable(get_tree().current_scene, FUNCTION)
	if callable.is_valid():
		callable.callv(PARAM)
	else:
		print("invalid function. Check the name, main scene, and parameters")
