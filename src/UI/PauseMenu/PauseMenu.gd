extends Panel

onready var scene_tree: SceneTree = get_tree()
var paused: = false setget set_paused
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var resumeButton = get_node("ResumeButton")
	var restartButton = get_node("RestartButton")
	var exitButton = get_node("ExitButton")
	
	resumeButton.connect("pressed", self, "ResumeButtonClick")
	restartButton.connect("pressed", self, "RestartButtonClick")
	exitButton.connect("pressed", self, "ExitButtonClick")
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = !paused
			
func ResumeButtonClick():
	paused = false
	scene_tree.paused = false
	self.visible = false

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	self.visible = value
	
func RestartButtonClick():
	paused = false
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func ExitButtonClick():
	paused = false
	get_tree().paused = false
	get_tree().change_scene("res://src/UI/MainMenu/MainMenu.tscn")
