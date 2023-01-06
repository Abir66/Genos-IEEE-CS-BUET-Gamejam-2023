extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var levelId: int
var sceneTree: SceneTree
var levelIDManager: Node2D
var dialog: Control
var root: Viewport
var onDialog: bool = false
var inGameOverlay: Control
var healthBar: TextureProgress
var chargeBar: TextureProgress

# Called when the node enters the scene tree for the first time.
func _ready():
	sceneTree = get_tree()
	root = sceneTree.get_root()
	levelIDManager = get_node("level" + str(levelId) + "_manager")
	# dialog = root.get_node("Level/ui/DialogTest")
	inGameOverlay = get_node("ui/in_game_overlay")
	sceneTree.paused = false
	healthBar = inGameOverlay.get_node("HealthBar")
	chargeBar = inGameOverlay.get_node("ChargeBar")
	# dialog.set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func EnemyDied(enemyName: String):
	print(enemyName + " died")
	levelIDManager.EnemyDied(enemyName)

func GameOver():
	print("gameOver")
	
	sceneTree.paused = true

func LevelComplete():
	print("level complete")
	
	sceneTree.paused = true
