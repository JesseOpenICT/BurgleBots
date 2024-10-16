extends Node

var abilities : Array = [
	# 0 = none gun
	{
		"name"			: "none",
		"image"			: "res://icon.svg",
		"brand"			: "none",
		"node"			: "res://Scenes/Buffs/none_gun.tscn",
		"color"			: Vector3(0.1,0.1,0.1),
		"weapon"		: true,
		"description"	: 
			"No ability"
	},
	# 1 = Steady Shock Emitter
	{
		"name"			: "Steady Shock Emitter",
		"image"			: "res://icon.svg",
		"brand"			: "Lactin",
		"node"			: "res://Scenes/Buffs/steady Shock emitter.tscn",
		"color"			: Vector3(0.1,0.1,0.1),
		"weapon"		: true,
		"description"	: 
			"Your attack rapidly deals Yellow damage"
	},
]

var brands : Dictionary = {
	"none"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0.1,0.1,0.1)
	},
	"Brass Apollo"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0.8, 0.58, 0.29)
	},
	"Flush"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0.26,0.18,0.85)
	},
	"Heartbrush"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0.93,0.53,0)
	},
	"Insect"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0.85,0,0)
	},
	"Jammy"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0,0.6,0.33)
	},
	"Lactin"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0.93,0.73,0)
	},
	"Mike Shack"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(1,0.6,0.6)
	},
	"P. Shell"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0.13,0.13,0.2)
	},
	"Rivers Energy"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0.13,0.73,0)
	},
	"Starfall"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0.6,0,0.73)
	},
	"Transfer"={
		"logo"			: "res://icon.svg",
		"color"			: Vector3(0,0.73,0.93)
	},
}


# Save system

var RUN_FILE : String = "user://RUNSAVE.json"

var RUN_DATA = {
	difficulty = 0,
	rngseed = 0, 
	rnglevelstate = 0, 
	rngshopstate  = 0,
	level = 0,
	money = 0,
	upgrades = [
		0,
	],
	loadout = [
		[0,0,0,0,], 
		[0,0,0,0,],
		[0,0,0,0,],
		[0,0,0,0,],
		[0,0,0,0,],
		[0,0,0,0,],
		[1,0,0,0,],
	],
	appearance = [0, 0, 0, 0, 0, 0, 0]
}

func saverun():
	var save = JSON.stringify(RUN_DATA)
	var path = RUN_FILE
	var save_game = FileAccess.open(path, FileAccess.WRITE)
	save_game.store_line(save)

func loadrun():
	if FileAccess.file_exists(RUN_FILE):
		var savestring = FileAccess.get_file_as_string(RUN_FILE)
		var save = JSON.parse_string(savestring)
		if save != null:
			RUN_DATA = save
