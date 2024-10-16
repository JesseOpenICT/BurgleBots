extends Node3D
class_name Weapon

@export var brand : int = 0
@export var damage : int = 10
@export var firerate : float = 2
var cooldown : float = 0
@export var range : float = 10
@export var color : String = "Gray" # Gray, Red, Orange, Yellow, Lime, Cyan, Indigo
@export var tint : Vector3 = Vector3(.1,.1,.1)
@export var target : Node = null
