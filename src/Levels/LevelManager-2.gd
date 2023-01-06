extends Node2D

var level : Node
var cmaera_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level("Level02")
	#position = Vector2.ZERO


func load_level(level_name):
	
	if is_instance_valid(level):level.queue_free()
	level = load("res://src/Levels/" + level_name + "/Scene.tscn").instance()
	level.position = Vector2.ZERO
	$LevelContainer.add_child(level)
	
	# Connect signals
	level.connect("level_clear", self, "on_level_clear")
	
	

func restart_level():
	pass
	
func level_lost():
	pass
	
func level_win():
	pass
	
func next_level():
	load_level("Level-3")

func on_level_clear():
	print("got signal")
	next_level()


# Signals
