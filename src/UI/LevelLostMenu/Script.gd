extends Panel

signal exit_button
signal restart_button

func _ready():
	var restartButton = get_node("RestartButton")
	var exitButton = get_node("ExitButton")
	
	restartButton.connect("pressed", self, "RestartButtonClick")
	exitButton.connect("pressed", self, "ExitButtonClick")
	

func RestartButtonClick():
	emit_signal("restart_button")
	
func ExitButtonClick():
	emit_signal("exit_button")
