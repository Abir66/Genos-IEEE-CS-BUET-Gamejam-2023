tool
extends Button

export(String, FILE) var next_scene_path: = ""
var level_no = 0
onready var game_data = SaveProgress.game_data

func _on_button_up() -> void:	
	if game_data.unlocked >= level_no:
		get_tree().change_scene(next_scene_path)
	else:
		print(level_no)

func _get_configuration_warning() -> String:
	return "The property Next Level can't be empty" if next_scene_path == "" else ""
