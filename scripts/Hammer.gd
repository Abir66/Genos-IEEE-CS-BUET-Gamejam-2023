extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var dropTime = 0.5
export var upTime = 1
export var dropWait = 3
export var upWait = 3
var state = 'UP_WAIT'
var time = 0
var hammer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	hammer = get_node("Hammer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(hammer)
	print(state + ' ' + str(time))
	
	if state == 'UP_WAIT':
		if time >= upWait:
			state = 'UP'
			time = 0
			hammer.linear_velocity = Vector2(0, -30 / upTime)
		else:
			time += delta
	elif state == 'UP':
		if time >= upTime:
			state = 'DOWN_WAIT'
			time = 0
			hammer.position = Vector2(0, 0)
		else:
			time += delta
			hammer.position += Vector2(0, -30 / upTime) * delta
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
			hammer.position = Vector2(0, 30)
		else:
			time += delta
			hammer.position += Vector2(0, 30 / dropTime) * delta
