extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var startButton = get_node("MainMenuPanel/StartButton")
	var creditButton = get_node("MainMenuPanel/CreditsButton")
	var exitButton = get_node("MainMenuPanel/ExitButton")
	
	startButton.connect("pressed", self, "StartButtonClick")
	creditButton.connect("pressed", self, "CreditButtonClick")
	exitButton.connect("pressed", self, "ExitButtonClick")
	
	get_node("LevelSelector").visible = false
	get_node("Credits").visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func StartButtonClick():
	get_node("LevelSelector").visible = true
#	get_tree().change_scene("res://src/UI/LevelSelector/LevelSelector.tscn")

func ExitButtonClick():
	get_tree().quit()

func CreditButtonClick():
	get_node("Credits").visible = true
