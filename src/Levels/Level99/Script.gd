extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal level_clear
signal set_charge
signal set_health

var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = $Player/Camera2D
	camera.make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("kill"):
		get_tree().quit()
		emit_signal("level_clear")
		print("signal emitted")

func _on_Player_set_charge(charge_value):
	emit_signal("set_charge", charge_value)


func _on_Player_set_health(health_value):
	emit_signal("set_health", health_value)


func _on_Player_player_died():
	print("Player died...")
	$Camera2D.position = $Player/Camera2D.position
	$Camera2D.custom_viewport = $Player/Camera2D.get_viewport()
	
