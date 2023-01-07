extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var backButton = get_node("LevelSelectorPanel/BackButton")
	backButton.connect("pressed", self, "BackButtonClick")
	
	for i in GameData.total_levels:
		var button = load("res://src/UI/LevelSelector/LevelButton.tscn").instance()
		button.get_node("Label").text = "Level " + str(i+1);
		button.level_no = i+1
		if(i >= GameData.max_level_reached):
			button.get_node("TextureRect").modulate.a = 0.2
		get_node("LevelSelectorPanel/GridContainer").add_child(button)


func BackButtonClick():
#	get_tree().change_scene("res://src/UI/MainMenu/MainMenu.tscn")
	self.visible = false
