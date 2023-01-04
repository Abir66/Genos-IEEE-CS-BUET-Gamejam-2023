extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var backButton = get_node("LevelSelectorPanel/BackButton")
	backButton.connect("pressed", self, "BackButtonClick")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func BackButtonClick():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
