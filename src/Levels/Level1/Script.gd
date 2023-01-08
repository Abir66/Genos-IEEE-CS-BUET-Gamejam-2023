extends Node2D

signal level_clear
signal set_charge
signal set_health
signal level_lost

var camera : Camera2D
var is_player_alive : bool

var dialogues = ["Hello, Genos! This is your trainer program speaking...", "Throughout this training session, you need to follow my instructions, is that clear?",
 "Genos(You) : *confused robot noise*", "Can you see the stairs in front of you?", "Go to the top and wait for next instruction"]

var call_again = true
# Called when the node enters the scene tree for the first time.
func _ready():
	is_player_alive = true
	camera = $Player/Camera2D
	camera.make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if call_again: check_lose_condition()
	if call_again: check_win_condition()		

func _on_Player_set_charge(charge_value):
	emit_signal("set_charge", charge_value)


func _on_Player_set_health(health_value):
	emit_signal("set_health", health_value)


func _on_Player_player_died():
	is_player_alive = false
	if call_again:check_lose_condition()
	if call_again:check_win_condition()
#	
	
# Caution : Check if player is alive before using $Player
func check_win_condition():
	pass


func check_lose_condition():
	if not is_player_alive:
		call_again = false
		emit_signal("level_lost")	


func _on_Player_tile_accept():
	call_again = false
	emit_signal("level_clear")


func _on_Player_tile_reject():
	$Player.kill()
