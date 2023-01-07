extends Node2D

const SAVE_FILE = "user://save.dat"

var level_to_load:int = 1
var max_level_reached:int = 1
export var total_levels:int = 10

func _ready() -> void:
	load_data()

func level_complete(level_no:int):
	if level_no > max_level_reached:
		max_level_reached = level_no
	save_data()
	
func save_data():
	var file = File.new()
	file.open(SAVE_FILE,File.WRITE)
	file.store_32(max_level_reached)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		max_level_reached = 1
		save_data()
	file.open(SAVE_FILE,File.READ)
	max_level_reached = file.get_32()
	file.close()
