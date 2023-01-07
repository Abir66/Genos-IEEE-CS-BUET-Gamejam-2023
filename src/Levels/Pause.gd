extends Control

func _input(event):
	if Input.is_action_pressed("pause") and not GameData.level_lost:
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused	
