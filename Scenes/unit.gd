extends CharacterBody3D

@onready var NavAgent : NavigationAgent3D = $NavAgent

var Statisfied : bool = false

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _physics_process(delta):
	if NavAgent.target_position.distance_to(position) >= 0.7 and not Statisfied:
		var nextlocation = NavAgent.get_next_path_position()
		velocity = (nextlocation - global_transform.origin).normalized() * SPEED
	else:
		Statisfied = true
		velocity = Vector3(0,0,0)
		#for i in $FriendRange.get_overlapping_bodies():
		#	i.statisfy()
	
	NavAgent.set_velocity(velocity)
	

func statisfy():
	Statisfied = true

func select(setto):
	$Selected.visible = setto

func set_target_location(location):
	Statisfied = false
	NavAgent.target_position = location
	NavAgent.target_position.y = 0


func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 4.25)
	move_and_slide()
