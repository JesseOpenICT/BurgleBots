extends CharacterBody3D

@export var TYPE : String = "common"
# treasure can be common or main
var targetable : bool = true
var CARRIEDBY = null

func _process(delta):
	$CollisionShape3D.disabled = !targetable
	if CARRIEDBY == null:
		global_position = global_position.move_toward(Vector3(global_position.x, 0, global_position.z), 12*delta)
		#global_position = Vector3(global_position.x, 0, global_position.z)
		targetable = true
	else:
		$CollisionShape3D.disabled = true
		global_position = global_position.move_toward(CARRIEDBY.global_position + Vector3(0,1,0), 12*delta)

func collect():
	# increase score (TBA)
	# Spawn particles (TBA)
	CARRIEDBY.drop()
	queue_free()
