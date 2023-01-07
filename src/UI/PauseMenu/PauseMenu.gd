extends Panel

signal resume_button
signal exit_button
signal restart_button

func _ready():
	var resumeButton = get_node("ResumeButton")
	var restartButton = get_node("RestartButton")
	var exitButton = get_node("ExitButton")
	
	resumeButton.connect("pressed", self, "ResumeButtonClick")
	restartButton.connect("pressed", self, "RestartButtonClick")
	exitButton.connect("pressed", self, "ExitButtonClick")
	
func ResumeButtonClick():
	emit_signal("resume_button")

func RestartButtonClick():
	emit_signal("restart_button")
	
func ExitButtonClick():
	emit_signal("exit_button")
