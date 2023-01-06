extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var dropTime = 0.5
export var upTime = 1
export var dropWait = 3
export var upWait = 3
var state = 'DOWN_WAIT'
var time = 0
var hammer = null
export var maxDistance: float = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	hammer = get_node("Hammer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 'UP_WAIT':
		if time >= upWait:
			state = 'UP'
			time = 0
			hammer.linear_velocity = Vector2(0, -maxDistance / upTime)
		else:
			time += delta
	elif state == 'UP':
		if time >= upTime:
			state = 'DOWN_WAIT'
			time = 0
			hammer.position = Vector2(0, 0)
		else:
			time += delta
			hammer.position += Vector2(0, -maxDistance / upTime) * delta
	elif state == 'DOWN_WAIT':
		if time >= upWait:
			state = 'DOWN'
			time = 0
		else:
			time += delta
	else:
		if time >= dropTime:
			state = 'UP_WAIT'
			time = 0
			hammer.position = Vector2(0, maxDistance)
		else:
			time += delta
			hammer.position += Vector2(0, maxDistance / dropTime) * delta


func _on_Area2D_body_entered(body):
	if state == "DOWN" and body.name == "Player":
		PlayerData.charge = 0
