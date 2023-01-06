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


func _on_DialogTrigger_body_entered(body):
	if body.name == "Player":
		levelManager.dialog.set_process(true)
		levelManager.onDialog = true
		queue_free()
