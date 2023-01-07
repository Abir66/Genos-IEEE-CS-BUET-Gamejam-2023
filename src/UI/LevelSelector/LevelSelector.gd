extends Control

func _ready():
	for i in GameData.total_levels:
		var button = load("res://src/UI/LevelSelector/LevelButton.tscn").instance()
		button.get_node("Label").text = "Level " + str(i+1);
		button.level_no = i+1
		if(i >= GameData.max_level_reached):
			button.get_node("TextureRect").modulate.a = 0.2
			button.get_node("Label").modulate.a = 0.2
			button.focus_mode = FOCUS_NONE
			button.disabled = true
		get_node("LevelSelectorPanel/GridContainer").add_child(button)

func update_levels():
	print(GameData.max_level_reached)
	var i:int = 1;
	for button in get_node("LevelSelectorPanel/GridContainer").get_children():
		button.level_no = i
		if(i <= GameData.max_level_reached):
			button.get_node("TextureRect").modulate.a = 1
			button.get_node("Label").modulate.a = 1
			button.focus_mode = FOCUS_ALL
			button.disabled = false
		i += 1
	
func _on_BackButton_pressed() -> void:
	self.visible = false
