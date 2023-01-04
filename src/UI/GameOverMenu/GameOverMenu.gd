extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var retryButton = get_node("RetryButton")
	var exitButton = get_node("ExitButton")
	
	retryButton.connect("pressed", self, "RetryButtonClick")
	exitButton.connect("pressed", self, "ExitButtonClick")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func RetryButtonClick():
	pass # pore :3

func ExitButtonClick():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
