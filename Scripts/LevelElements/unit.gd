extends CharacterBody3D

@onready var NavAgent : NavigationAgent3D = $NavAgent

var Statisfied : bool = false
var Objective : Node = null
var Carrying : Node = null

var heart : Heart = Heart.new()
var weapon : Node
var abilities : Array[Node] = []

const SPEED_DEFAULT : float = 5.0
var SPEED : float = SPEED_DEFAULT
const RECOVERY_DEFAULT : float = 1.
var RECOVERY_SPEED : float = 1.



func _physics_process(delta):
	position.y = 0
	# get and go to objective
	weapon.target = null
	if Objective != null:
		set_target_location(Objective.position)
		if Objective.visible == false:
			set_target_location(Objective.position)
			Objective = null
		elif Objective.targetable == false:
			Statisfied = true
			Objective = null
		elif Objective.is_in_group("Treasure"):
			$PickupRange.monitoring = false
			$PickupRange.monitoring = true
			set_target_location(Objective.position)
			if !Objective.targetable:
				Objective = null
				NavAgent.target_position = global_position
		elif Objective.is_in_group("Enemy"):
			if position.distance_to(Objective.position) > weapon.range+Objective.size:
				set_target_location(Objective.position)
				Statisfied = false
				weapon.target = null
			else :
				Statisfied = true
				if not Carrying:
					weapon.target = Objective
				weapon.recovery_speed = RECOVERY_SPEED
	
	# pathfind
	if NavAgent.target_position.distance_to(position) >= 0.7 and not Statisfied:
		var nextlocation = NavAgent.get_next_path_position()
		velocity = (nextlocation - global_transform.origin).normalized() * SPEED
	else:
		Statisfied = true
		velocity = Vector3(0,0,0)
	
	NavAgent.set_velocity(velocity)
	

func statisfy():
	Statisfied = true

func select(setto):
	$Selected.visible = setto

func set_target_location(location):
	Statisfied = false
	NavAgent.target_position = location
	NavAgent.target_position.y = 0

func set_target_objective(objective):
	Statisfied = false
	Objective = objective

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 4.25)
	move_and_slide()



func _on_pickup_range_body_entered(body): # if the unit reaches its objective which is a treasure it'll pick it up
	if body == Objective and Carrying == null and Objective.is_in_group("Treasure"):
		Objective.targetable = false
		Objective.CARRIEDBY = self
		Carrying = Objective
		pickup()



# filter abilities

#Attack filters (deal more damage)
#Defense filters (take less damage)
#Land Attack (post attack filter)
#Take Attack (NVM Defense filter)
#On added (abilities only)
#On removed (abilities only)
#Ongoing (abilities only)
#On enemy defeated (get trigger from level scene)
#On self defeated (resurrection)
#On treasure pickup 
#On treasure drop
#On treasure collected for one ability and nothing else lmao

func attack_filters(attack):
	for ability in abilities:
		if ability.has_method("attack_filter"):
			attack = ability.attack_filter(attack)
	weapon.fire_post(attack)

func land_attack(attack):
	for ability in abilities:
		if ability.has_method("land_attack"):
			ability.land_attack(attack)

func take_attack(attack):
	for ability in abilities:
		if ability.has_method("take_attack"):
			attack = ability.take_attack(attack)
	heart.health -= attack.amount
	if heart.health <= 0:
		die()

func update_speed():
	SPEED = SPEED_DEFAULT
	RECOVERY_SPEED = RECOVERY_DEFAULT
	var stats = [SPEED, RECOVERY_SPEED]
	for ability in abilities:
		if ability.has_method("update_speed"):
			stats = ability.update_speed(SPEED, RECOVERY_SPEED)
			SPEED = stats[0]
			RECOVERY_SPEED = stats[1]

func pickup():
	var carryingbuff = load("res://Scenes/Buffs/Statuses/Carrying.tscn").instantiate()
	abilities.append(carryingbuff)
	add_child(carryingbuff)
	
	for ability in abilities:
		if ability.has_method("pickup"):
			ability.pickup()

func drop():
	Carrying.CARRIEDBY = null
	Carrying.position += Vector3(0.1,0.2,0)
	Carrying = null
	for ability in abilities:
		if ability.has_method("drop"):
			ability.drop()


func die(): # If the unit has a resurrection ability, it gets used here by setting lethal to something else that gets returned.
	var lethal = 0
	for ability in abilities:
		if lethal != 0:
			break
		if ability.has_method("die"):
			lethal = ability.die()
	if lethal==0:
		queue_free()
	else:
		heart.health = lethal
