extends Control

func _ready():
	for i in GameData.total_levels:
		var button = load("res://src/UI/LevelSelector/LevelButton.tscn").instance()
		button.get_node("Label").text = "Level " + str(i+1);
		button.level_no = i+1
		if(i >= GameData.max_level_reached):
			button.get_node("TextureRect").modulate.a = 0.2
			button.get_node("Label").modulate.a = 0.2
		get_node("LevelSelectorPanel/GridContainer").add_child(button)

func _on_BackButton_pressed() -> void:
	self.visible = false
