extends Control


func _input(event):
	if Input.is_action_pressed("pause"):
		print("tried to pause")
		var new_pause_state = get_tree().paused
		get_tree().paused = not new_pause_state
		visible = new_pause_state
		
