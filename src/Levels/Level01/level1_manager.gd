extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var levelManager: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	levelManager = get_parent()

func EnemyDied(enemyName: String):
	if enemyName == "1":
		levelManager.GameOver()
	elif enemyName == "2":
		levelManager.LevelComplete()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
