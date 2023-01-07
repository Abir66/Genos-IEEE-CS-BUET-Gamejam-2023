extends Node

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")



func fade_in() -> void:
	anim_player.play("Fade_In")
	yield(anim_player, "animation_finished")
	

func fade_out() -> void:
	anim_player.play_backwards("Fade_In")
	yield(anim_player, "animation_finished")
	
