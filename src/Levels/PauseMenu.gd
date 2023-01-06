extends CanvasLayer


func _input(event):
	
	if Input.is_action_pressed("kill"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
