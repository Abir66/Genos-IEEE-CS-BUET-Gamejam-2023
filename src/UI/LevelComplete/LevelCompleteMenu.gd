extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var nextButton = get_node("NextButton")
	var retryButton = get_node("RetryButton")
	var exitButton = get_node("ExitButton")
	
	nextButton.connect("pressed", self, "NextButtonClick")
	retryButton.connect("pressed", self, "RetryButtonClick")
	exitButton.connect("pressed", self, "ExitButtonClick")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func NextButtonClick():
	pass # UwU
	
func RetryButtonClick():
	pass # UwUwU
	
func ExitButtonClick():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
