extends Node2D

signal level_clear
signal set_charge
signal set_health
signal level_lost

var camera : Camera2D
var is_player_alive : bool

var dialogues = ["This is a dialogue", "test 1 ", "test 2", "test 3", "4", "5"]

# Called when the node enters the scene tree for the first time.
func _ready():
	is_player_alive = true
	camera = $Player/Camera2D
	camera.make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	check_lose_condition()
	check_win_condition()		

func _on_Player_set_charge(charge_value):
	emit_signal("set_charge", charge_value)


func _on_Player_set_health(health_value):
	emit_signal("set_health", health_value)


func _on_Player_player_died():
	is_player_alive = false
	check_lose_condition()
	check_win_condition()
#	$Camera2D.position = $Player/Camera2D.position
#	$Camera2D.custom_viewport = $Player/Camera2D.get_viewport()
	

# Caution : Check if player is alive before using $Player
func check_win_condition():
	pass


func check_lose_condition():
	if not is_player_alive:
		emit_signal("level_lost")	



func _on_Player_tile_accept():
	emit_signal("level_clear")


func _on_Player_tile_reject():
	$Player.kill()
