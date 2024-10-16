extends CharacterBody3D

var targetable : bool = true

var heart : Heart = Heart.new()

@export var health : int
@export var size = 1

func _ready():
	heart.maxhealth = health
	heart.health = health


func take_attack(attack):
	heart.health -= attack.amount
	if heart.health <= 0:
		targetable = false
		queue_free()
