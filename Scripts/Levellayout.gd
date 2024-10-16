extends Node

@export var spawner : Node3D
@export var spawnpositions : Array[Node3D]
@export var camera_data_min : Vector2
@export var camera_data_max : Vector2

func _ready():
	$NavigationRegion3D.bake_navigation_mesh()
