extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var startButton = get_node("StartButton")
	var exitButton = get_node("ExitButton")
	
	startButton.connect("pressed", self, "StartButtonClick")
	exitButton.connect("pressed", self, "ExitButtonClick")
	
	get_node("LevelSelector").visible = false



func StartButtonClick():
	get_node("LevelSelector").visible = true
#	get_tree().change_scene("res://src/UI/LevelSelector/LevelSelector.tscn")

func ExitButtonClick():
	get_tree().quit()
