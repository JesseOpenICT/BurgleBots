extends Weapon

@export var projectile : PackedScene = preload("res://Scenes/Attacks/projectile_attack.tscn")
var recovery_speed = 1.

func _ready():
	get_parent().update_speed()

func _process(delta):
	if target:
		if cooldown >= 0:
			cooldown-=firerate
			fire_prep()
		else:
			cooldown += delta*recovery_speed
	else:
		cooldown = clamp(cooldown+delta*recovery_speed, -firerate, 0)

func fire_prep():
	var attack :Attack = Attack.new()
	attack.amount = damage
	attack.color = color
	attack.source = get_parent()
	attack.target = target
	attack.tint = tint
#	get_parent().attack_filters(attack)

#func fire_post(attack):
	#spawn bullet
	var bullet = projectile.instantiate()
	bullet.global_position = global_position
	bullet.scale = Vector3(.5,.5,.5)
	bullet.attack = attack
	get_tree().current_scene.currentscene.add_child(bullet)

func land_attack(attack):
	print(attack.amount)
	attack.amount*=5
	print(attack.amount)
#	attack.target.heart.temperature += +0.5

#func update_speed(speed, recovery):
#	return [speed*2 , recovery*20]
