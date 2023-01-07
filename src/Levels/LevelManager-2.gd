extends Node2D

var level : Node
var level_no : int

func _ready():
	load_level(2)
	
	
func load_level(level_no):
	self.level_no = level_no
	if is_instance_valid(level) : level.queue_free()
	level = load("res://src/Levels/Level" + String(level_no) + "/Scene.tscn").instance()
	level.position = Vector2.ZERO
	$LevelContainer.add_child(level)
	
	# Connect signals
	level.connect("level_clear", self, "on_level_clear")
	level.connect("level_lost", self, "on_level_lost")
	level.connect("set_charge", self, "set_charge")
	level.connect("set_health", self, "set_health")
	
	set_health(level.get_node("Player").get_health())
	set_charge(level.get_node("Player").get_charge())
	
	GameData.level_lost = false
	$InGameMenu/Pause.visible = false
	
	
	
func restart_level():
	load_level(GameData.level_to_load)
		
func next_level():
	if GameData.has_next_level() : 
		GameData.set_next_level()
		load_level(GameData.level_to_load)
	

func on_level_clear():
	GameData.level_complete(level_no)
	next_level()

func on_level_lost():
	GameData.level_lost = true
	#pause and show game over menu
	next_level()
	
	

# Signals
func set_health(health_value):
	$UI/HealthBar.set_value(health_value)
	
func set_charge(charge_value):
	$UI/ChargeBar.set_value(charge_value)


func _on_PauseMenuPanel_exit_button():
	get_tree().paused = false
	$InGameMenu/Pause.visible = false
	# need to add scene change to main menu
	


func _on_PauseMenuPanel_restart_button():
	get_tree().paused = false
	$InGameMenu/Pause.visible = false
	restart_level()


func _on_PauseMenuPanel_resume_button():
	get_tree().paused = false
	$InGameMenu/Pause.visible = false
