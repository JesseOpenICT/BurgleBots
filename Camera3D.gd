extends Camera3D

var StartMousePos : Vector3
var SelectedUnits : Array

@onready var GlowBox : VisualInstance3D = $MarkerCube
@onready var SelectBox : CollisionShape3D = $MarkerCube/MarkerZone/MarkerZoneArea

# COLISSION MASK LAYERS:
# LAYER 1 = Objects
# LAYER 2 = Terrain
# LAYER 3 = Units
# LAYER 4 = Terrain AND all physics objects including units


func _ready():
	pass


func _process(delta):
	GlowBox.global_position = (getscreenposition()+StartMousePos) / 2
	GlowBox.mesh.size = abs(StartMousePos-getscreenposition()) + Vector3(0,2,0)
	SelectBox.shape.size = GlowBox.mesh.size


func _input(event):
	if Input.is_action_just_pressed("LMB") or Input.is_action_just_pressed("MMB"):
		$RayCast3D.set_collision_mask_value(1, false)
		StartMousePos = getscreenposition()
		GlowBox.visible = true
	if Input.is_action_just_released("LMB"):
		$RayCast3D.set_collision_mask_value(1, true)
		GlowBox.visible = false
		select(Input.is_action_pressed("tool"))
	if Input.is_action_just_released("MMB"):
		$RayCast3D.set_collision_mask_value(1, true)
		GlowBox.visible = false
		select(true)
	
	if Input.is_action_just_released("RMB"):
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
	print($MarkerCube/MarkerZone.get_overlapping_bodies().size() )
	if $MarkerCube/MarkerZone.get_overlapping_bodies().size() == 0:
		$RayCast3D.set_collision_mask_value(3, true)
		var target = getcoltarget()
		if target == null:
			pass
		elif target.has_method("select"):
				target.select(true)
				SelectedUnits.append(target)
	else:
		for object in $MarkerCube/MarkerZone.get_overlapping_bodies():
			if object.has_method("select"):
				object.select(true)
				SelectedUnits.append(object)
