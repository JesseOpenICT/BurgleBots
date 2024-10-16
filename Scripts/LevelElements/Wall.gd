extends MeshInstance3D

var box
var shape

func _enter_tree():
	box = StaticBody3D.new()
	
	box.set_collision_mask_value(1, false)
	box.set_collision_mask_value(4, true)
	box.set_collision_layer_value(1, false)
	box.set_collision_layer_value(4, true)
	box.add_to_group("Terrain")
	
	add_child(box)
	
	shape = CollisionShape3D.new()
	
	shape.shape = BoxShape3D.new()
	shape.shape.size = mesh.size
	box.add_child(shape)
