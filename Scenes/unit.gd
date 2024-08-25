extends CharacterBody3D

@onready var NavAgent : NavigationAgent3D = $NavAgent

var Statisfied : bool = false
var Objective = null

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _physics_process(delta):
	# get and go to objective
	if Objective != null:
		set_target_location(Objective.position)
		if Objective.visible == false and Objective.targetable == false:
			pass
			Statisfied = true
		elif Objective.is_in_group("Treasure"):
			set_target_location(Objective.position)
			if !Objective.targetable:
				Objective = null
				NavAgent.target_position = global_position
		elif Objective.is_in_group("Enemy"):
			pass
	
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
	print(Objective)
	Statisfied = false
	NavAgent.target_position = location
	NavAgent.target_position.y = 0

func set_target_objective(objective):
	Statisfied = false
	Objective = objective

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 4.25)
	move_and_slide()





func _on_pickup_range_body_entered(body):
	if body == Objective:
		Objective.targetable = false
		Objective.CARRIEDBY = self
