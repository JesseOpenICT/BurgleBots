extends MeshInstance3D

var box : Area3D
var shape : CollisionShape3D
var entered : bool = false

@export var spotlights : Array[Node]

var process : float = 1

@export var materi : Shader

func _process(delta):
	process = move_toward(process, 1-int(entered), 2*delta)
	mesh.material.set("shader_parameter/loadprogress", process)

func _ready():
	mesh.material = ShaderMaterial.new()
	mesh.material.shader = load("res://Assets/Textures/DarkRoom.gdshader")
	mesh.material.set("shader_parameter/bubbles", load("res://Assets/GradientCircle.png"))
	
	box = Area3D.new()
	
	box.set_collision_mask_value(1, false)
	box.set_collision_mask_value(4, true)
	box.set_collision_layer_value(1, false)
	box.set_collision_layer_value(4, true)
	box.add_to_group("Room")
	
	add_child(box)
	
	shape = CollisionShape3D.new()
	
	shape.shape = BoxShape3D.new()
	shape.shape.size = Vector3(mesh.size.x, 3, mesh.size.y)
	box.add_child(shape)
	
	box.monitoring = true
	box.body_entered.connect(body_entered, 1)
	box.body_exited.connect(body_exited, 1)

func body_entered(body:Node):
	if body.is_in_group("Unit"):
		entered = true
		for object in box.get_overlapping_bodies():
			if object.is_in_group("Objective"):
				object.visible = true
	elif body.is_in_group("Objective"):
		body.visible = entered
	await get_tree().create_timer(0.1).timeout
	for light in spotlights:
		light.visible = entered

func body_exited(body):
	var units = false
	for object in box.get_overlapping_bodies():
		if object.is_in_group("Unit"):
			units = true
			break
	if not units:
		entered = false
		for object in box.get_overlapping_bodies():
			if object.is_in_group("Objective"):
				object.visible = entered
	await get_tree().create_timer(0.1).timeout
	for light in spotlights:
		light.visible = entered
