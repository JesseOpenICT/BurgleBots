extends Node

var currentscene : Node
@onready var DATA : Node = $RunSaveLoader

var SCENES : Dictionary = {
	MAIN_MENU 	= "res://Scenes/main_menu.tscn",
	SETUP		= "",
	LEVEL 		= "res://Scenes/level.tscn",
}


func _ready():
	DATA.loadrun()
	DATA.saverun()
	engage("MAIN_MENU")


func engage(scene):
	loadcover(true)
	if currentscene:
		currentscene.queue_free()
	
	currentscene = load(SCENES[scene]).instantiate()
	add_child(currentscene)
	await get_tree().create_timer(0.2).timeout
	loadcover(false)

func exit():
	get_tree().quit()

func loadcover(loading):
	$LoadingCover.visible = loading
