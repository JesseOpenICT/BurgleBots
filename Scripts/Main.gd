extends Node

var currentscene : Node

var SCENES : Dictionary = {
	MAIN_MENU 	= "res://Scenes/main_menu.tscn",
	DIFFICULTY	= "",
	SETUP		= "",
	LEVEL 		= "res://Scenes/level.tscn",
}


func _ready():
	GameData.saverun()
	GameData.loadrun()
	GameData.saverun()
	engage("MAIN_MENU")


func engage(scene):
	
	if currentscene:
		loadcover(true)
		await get_tree().create_timer(.75).timeout
		currentscene.queue_free()
	
	currentscene = load(SCENES[scene]).instantiate()
	add_child(currentscene)
	await get_tree().create_timer(.75).timeout
	loadcover(false)

func exit():
	get_tree().quit()

func loadcover(loading):
	$LoadingCover.active = loading
