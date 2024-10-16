extends ColorRect

var active : bool = 1
var progress : float = 1

func _process(delta):
	progress = move_toward(progress, active, 1.5*delta)
	material.set("shader_parameter/loadprogress", progress)
	material.set("shader_parameter/angle", active)
