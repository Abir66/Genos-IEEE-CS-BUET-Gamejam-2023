tool
class_name Portal2D extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

signal level_clear

func teleport() -> void:
	anim_player.play("Fade_In")
	yield(anim_player, "animation_finished")
	emit_signal("level_clear")

func _on_body_entered(body: Node) -> void:
	teleport()

