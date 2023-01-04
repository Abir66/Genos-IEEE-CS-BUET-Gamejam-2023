extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var game_data = SaveProgress.game_data
# Called when the node enters the scene tree for the first time.
func _ready():
	var backButton = get_node("LevelSelectorPanel/BackButton")
	backButton.connect("pressed", self, "BackButtonClick")
	
	var i:int = 1;
	for level_i in get_node("LevelSelectorPanel/LevelScroll/GridContainer").get_children():
		level_i.get_node("Label").text = "Level " + str(i);
		level_i.level_no = i
		if(i > game_data.unlocked):
			level_i.get_node("TextureRect").modulate.a = 0.2
		i += 1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func BackButtonClick():
	get_tree().change_scene("res://src/UI/MainMenu/MainMenu.tscn")
