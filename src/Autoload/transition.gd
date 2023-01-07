extends CanvasLayer


signal scene_changed()

onready var animation_player= $AnimationPlayer
onready var black= $Control/ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func change_scene(path, delay=0.5):
	yield(get_tree().create_timer(delay),"timeout")
	
	animation_player.play("") #name of the animation to play////////////////
	yield(animation_player,"animation_finished")
	
	
	assert(get_tree().change_scene(path)==OK)
	
	animation_player.play_backwards("")#name of the animation to play///////////////////////
	yield(animation_player,"animation_finished")
	
	emit_signal("scene_changed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
