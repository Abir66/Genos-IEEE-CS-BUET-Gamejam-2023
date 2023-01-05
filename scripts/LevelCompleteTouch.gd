extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var levelManager: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	levelManager = get_tree().get_root().get_node("level_root/level_manager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_level_complete_touch_body_entered(body):
	levelManager.LevelComplete()
