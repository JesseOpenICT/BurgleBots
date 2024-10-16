extends Node3D

var units : Array[Node] = []

var layout : Node

const spawnpoints : Array[Vector3] = [
	Vector3(-1,0,-3),
	Vector3(1,0,-3),
	Vector3(-2,0,0),
	Vector3(0,0,0),
	Vector3(2,0,0),
	Vector3(-1,0,3),
	Vector3(1,0,3),
]

func _ready():
	
	layout = $"Things that eventually gotta go" #replace with randomly selected level
	
	var robot_index = 0
	for loadout in GameData.RUN_DATA["loadout"]:
		var bot = load("res://Scenes/Level Elements/unit.tscn").instantiate()
		bot.global_position = layout.spawner.global_position + spawnpoints[robot_index]
		add_child(bot)
		var upgrade_index = 0
		for upgrade in loadout:
			if not upgrade_index:
				var upgrade_node : Node = load(GameData.abilities[upgrade]["node"]).instantiate()
				bot.add_child(upgrade_node)
				bot.abilities.append(upgrade_node)
				bot.weapon = upgrade_node
				print (bot.weapon)
			elif upgrade:
				var upgrade_node : Node = load(GameData.abilities[upgrade]["node"]).instantiate()
				bot.add_child(upgrade_node)
				bot.abilities.append(upgrade_node)
			upgrade_index+=1
		robot_index+=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
