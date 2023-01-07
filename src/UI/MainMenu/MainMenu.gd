extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("LevelSelector").visible = false
	get_node("Credits").visible = false



func _on_StartButton_pressed() -> void:
	get_node("LevelSelector").update_levels()
	get_node("LevelSelector").visible = true


func _on_CreditsButton_pressed() -> void:
	get_node("Credits").visible = true


func _on_ExitButton_pressed() -> void:
	get_tree().quit()
