extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var startButton = get_node("StartButton")
	var exitButton = get_node("ExitButton")
	
	startButton.connect("pressed", self, "StartButtonClick")
	exitButton.connect("pressed", self, "ExitButtonClick")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func StartButtonClick():
	get_tree().change_scene("res://scenes/LevelSelector.tscn")

func ExitButtonClick():
	get_tree().quit()
