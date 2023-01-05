extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var facing = "right"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if facing == "left": 
#		$AnimatedSprite.flip_h = false
		get_node("Laser_Left").set_process(true)
		get_node("Laser_Right").set_process(false)
		
	else : 
#		$AnimatedSprite.flip_h = true
		get_node("Laser_Left").set_process(false)
		get_node("Laser_Right").set_process(true)
		



	
