#tool
extends Button

#export(String, FILE) var next_scene_path: = ""
var level_no = 0

func _on_button_up() -> void:	
	if GameData.max_level_reached  >= level_no:
		GameData.level_to_load = level_no
		print("level_to_load="+ String(level_no))
		get_tree().change_scene("res://src/Levels/LevelManager-2.tscn")
	else:
		print(level_no)
#
#func _get_configuration_warning() -> String:
#	return "The property Next Level can't be empty" if next_scene_path == "" else ""
