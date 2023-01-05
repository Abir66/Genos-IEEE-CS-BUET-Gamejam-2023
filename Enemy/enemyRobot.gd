extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var spawn_location=Vector2(500.0,0)
export var enable_shooting=true
export var right_range=Vector2(400.0,0)
export var left_range=Vector2(400.0,0)
export var transition_speed=3

var current_location=Vector2.ZERO
var right_going=true

# Called when the node enters the scene tree for the first time.
func _ready():
	position=spawn_location
	current_location=spawn_location
	$AnimatedSprite.play("walk")
	$AnimatedSprite.flip_h=true
	
func _process(delta):
	current_location.x+=transition_speed
	position=current_location
	var right_limit=spawn_location+right_range
	var left_limit=spawn_location-left_range
	if position.x>right_limit.x:
		right_going=false;
		transition_speed=-transition_speed
		$AnimatedSprite.flip_h=false
		$Node2D.facing="left"
		
	elif position.x<left_limit.x:
		right_going=true
		transition_speed=-transition_speed
		$AnimatedSprite.flip_h=true
		$Node2D.facing="right"


func _on_Timer_timeout():
	pass # Replace with function body.
