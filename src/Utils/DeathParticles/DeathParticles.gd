extends Particles2D


onready var time_created = Time.get_ticks_msec()

# Called when the node enters the scene tree for the first time.
func _ready():
	$blast.play()
	$blastSoundTimer.start(0.7)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Time.get_ticks_msec() - time_created > 1000:
		$blast.stop()
		queue_free()
		


func _on_blastSoundTimer_timeout():
	$blast.stop()
