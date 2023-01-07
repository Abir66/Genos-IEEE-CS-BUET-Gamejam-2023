extends Control


func _ready():
	var backButton = get_node("CreditPanel/BackButton")
	backButton.connect("pressed", self, "BackButtonClick")

func BackButtonClick():
#	get_tree().change_scene("res://src/UI/MainMenu/MainMenu.tscn")
	self.visible = false
