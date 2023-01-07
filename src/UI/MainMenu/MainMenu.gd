extends Control


# Called when the node enters the scene tree for the first time.

onready var levelselector = get_node("LevelSelector")
func _ready():
	levelselector.visible = false
	get_node("Credits").visible = false

func _on_StartButton_pressed() -> void:
	levelselector.update_levels()
	levelselector.visible = true

func _on_CreditsButton_pressed() -> void:
	get_node("Credits").visible = true

func _on_ExitButton_pressed() -> void:
	get_tree().quit()
