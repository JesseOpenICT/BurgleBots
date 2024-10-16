extends Camera3D

var StartMousePos : Vector3
var SelectedUnits : Array

@export var LimitDistMin : Vector2 = Vector2(-100, -100)
@export var LimitDistMax : Vector2 = Vector2(100, 100)

@onready var GlowBox : VisualInstance3D = $MarkerCube
@onready var SelectBox : CollisionShape3D = $MarkerCube/MarkerZone/MarkerZoneArea

# COLISSION MASK LAYERS:
# LAYER 1 = Objects
# LAYER 2 = Terrain
# LAYER 3 = Units
# LAYER 4 = Terrain AND all physics objects including units


func _process(delta):
	if Input.is_action_pressed("right") and position.x < LimitDistMax.x:
		position.x += 10*delta
	if Input.is_action_pressed("left") and position.x > LimitDistMin.x:
		position.x -= 10*delta
	if Input.is_action_pressed("down") and position.z < LimitDistMax.y:
		position.z += 15*delta
	if Input.is_action_pressed("up") and position.z > LimitDistMin.y:
		position.z -= 15*delta
	
	GlowBox.global_position = (getscreenposition()+StartMousePos) / 2
	GlowBox.mesh.size = abs(StartMousePos-getscreenposition()) + Vector3(0,2,0)
	SelectBox.shape.size = GlowBox.mesh.size

func setraycast(targets:Array[int]):
	for layer in [1,2,3,4]:
		$RayCast3D.set_collision_mask_value(layer, targets.has(layer))

func _input(event):
	if Input.is_action_just_pressed("LMB") or Input.is_action_just_pressed("MMB"):
		setraycast([2])
		StartMousePos = getscreenposition()
		GlowBox.visible = true
	if Input.is_action_just_released("LMB"):
		setraycast([1,2])
		GlowBox.visible = false
		select(Input.is_action_pressed("tool"))
	if Input.is_action_just_released("MMB"):
		setraycast([1,2])
		GlowBox.visible = false
		select(true)
	
	if Input.is_action_just_released("RMB"):
		setraycast([1,2])
		var target = getcoltarget()
		if target != null:
			if target.is_in_group("Terrain"):
				var targetpos = $RayCast3D.get_collision_point()
				for unit in SelectedUnits:
					unit.set_target_location(targetpos)
					unit.set_target_objective(null)
			elif target.is_in_group("Objective"):
				for unit in SelectedUnits:
					unit.set_target_objective(target)
	
	if Input.is_action_just_pressed("tool") or Input.is_action_just_pressed("MMB"):
		GlowBox.get_surface_override_material(0).set_shader_parameter("color", Vector3(3, 0.8, 0))
	if (Input.is_action_just_released("tool") and not Input.is_action_pressed("MMB")) or Input.is_action_just_released("MMB"):
		GlowBox.get_surface_override_material(0).set_shader_parameter("color", Vector3(0.3, 1, 10))
	
	if Input.is_action_just_pressed("drop"):
		for unit in SelectedUnits:
			if unit.Carrying:
				unit.drop()

func getscreenposition():
	var spacestate = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var rayorigin = project_ray_origin(mousepos)
	
	$RayCast3D.global_position = rayorigin
	return $RayCast3D.get_collision_point()
	
func getcoltarget():
	var spacestate = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var rayorigin = project_ray_origin(mousepos)
	
	$RayCast3D.global_position = rayorigin
	return $RayCast3D.get_collider()

func select(additive):
	if not additive:
		for object in SelectedUnits:
			object.select(false)
		SelectedUnits = []
	if $MarkerCube/MarkerZone.get_overlapping_bodies().size() == 0:
		var units = get_tree().get_nodes_in_group("Unit")
		var distances : Array
		for unit in units:
			distances.append( getscreenposition().distance_to(unit.position))
		if distances.min() < 2:
			var selection = units[distances.find(distances.min())]
			selection.select(true)
			SelectedUnits.append(selection)
	else:
		for object in $MarkerCube/MarkerZone.get_overlapping_bodies():
			if object.has_method("select"):
				object.select(true)
				SelectedUnits.append(object)
