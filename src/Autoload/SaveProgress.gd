extends Node2D

const SAVE_FILE = "user://save.dat"

var game_data = {}
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func level_complete(level_no:int):
	if level_no > game_data.unlocked:
		game_data = {
			"unlocked": level_no
		}
	save_data()
	
func save_data():
	var file = File.new()
	file.open(SAVE_FILE,File.WRITE)
	file.store_var(game_data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		game_data = {
			"unlocked": 1
		}
		save_data()
	file.open(SAVE_FILE,File.READ)
	game_data = file.get_var()
	file.close()
