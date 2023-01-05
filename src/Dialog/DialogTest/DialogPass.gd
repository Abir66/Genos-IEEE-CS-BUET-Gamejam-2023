extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Array, String) var speechNames
var speeches: Array
var current: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for speechName in speechNames:
		speeches.append(get_node(speechName))
		
	speeches[0].visible = true

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			speeches[current].visible = false
			current += 1
			
			if current < speeches.size():
				speeches[current].visible = true
			else:
				queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
