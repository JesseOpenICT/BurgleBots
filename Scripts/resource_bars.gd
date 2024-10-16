extends Node3D

var health : float = 1 # health is 1-0
var temperature : float = 50 # temp is 0-100

func _process(delta):
	global_rotation = Vector3(0,0,0)
	if get_parent().heart:
		var heart = get_parent().heart
		
		health = move_toward(health,float(heart.health)/heart.maxhealth,delta*4)
		temperature = heart.temperature
		
		$HP.mesh.material.set("shader_parameter/value", health)
		if heart.health != heart.maxhealth:
			$HP.visible = true
		$TEMP.mesh.material.set("shader_parameter/value", temperature/100)
		if heart.temperature != 50:
			$TEMP.visible = true
