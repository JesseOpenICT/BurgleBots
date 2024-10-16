extends Node3D

var attack : Attack
var speed = 10

func _ready():
	for i in [$Outer,$Inner]:
		i.mesh.material.set("shader_parameter/color", attack.tint)
		

func _process(delta):
	if is_instance_valid(attack.target):
		look_at(attack.target.position)
		position = position.move_toward(attack.target.position, delta*speed)
		if position.distance_to(attack.target.position) < 0.2:
			attack.hit()
			queue_free()
	else:
		queue_free()
