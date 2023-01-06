extends Area2D


onready var anim_player: AnimationPlayer = $AnimationPlayer

export var charge: = 10


func _on_body_entered(body: PhysicsBody2D) -> void:
	picked(body)


func picked(body: PhysicsBody2D) -> void:
	body.got_battery(charge)
	anim_player.play("picked")
