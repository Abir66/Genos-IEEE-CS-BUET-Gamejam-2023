extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var levelId: int
var sceneTree: SceneTree
var dialog: Control
var root: Viewport
var onDialog: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sceneTree = get_tree()
	root = sceneTree.get_root()
	dialog = root.get_node("level_root/ui/DialogTest")
	
	sceneTree.paused = false
	dialog.set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func GameOver():
	print("gameOver")

func LevelComplete():
	print("level complete")
