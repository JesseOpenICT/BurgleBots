extends CharacterBody3D

@export var TYPE : String = "common"
# treasure can be common or main
var targetable : bool = true
var CARRIEDBY = null

func _process(delta):
	$CollisionShape3D.disabled = !targetable
	if CARRIEDBY == null:
		global_position.move_toward(Vector3(global_position.x, 0, global_position.y), 0.1*delta)
		targetable = true
	else:
		global_position = Vector3(CARRIEDBY.global_position.x, 1, CARRIEDBY.global_position.z)

func collect():
	# increase score (TBA)
	# Spawn particles (TBA)
	CARRIEDBY.Carrying = null
	CARRIEDBY = null
	queue_free()
