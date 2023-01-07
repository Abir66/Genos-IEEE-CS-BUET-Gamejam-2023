extends Node2D

var level : Node

func _ready():
	load_level("Level02")
	
func load_level(level_name):
	
	if is_instance_valid(level) and level != null :level.queue_free()
	level = load("res://src/Levels/" + level_name + "/Scene.tscn").instance()
	level.position = Vector2.ZERO
	$LevelContainer.add_child(level)
	
	# Connect signals
	level.connect("level_clear", self, "on_level_clear")
	level.connect("set_charge", self, "set_charge")
	level.connect("set_health", self, "set_health")
	
	set_health(level.get_node("Player").get_health())
	set_charge(level.get_node("Player").get_charge())
	
	
func restart_level():
	pass
	
	
func level_lost():
	pass
	
func level_win():
	pass
	
func next_level():
	load_level("Level02")

func on_level_clear():
	next_level()

# Signals
func set_health(health_value):
	$UI/HealthBar.set_value(health_value)
	
func set_charge(charge_value):
	$UI/ChargeBar.set_value(charge_value)
