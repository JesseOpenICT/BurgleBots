extends Node

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
		[0,0,0,0,],
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
