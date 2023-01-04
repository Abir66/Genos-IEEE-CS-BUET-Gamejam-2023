extends AnimatedSprite


func _ready():
	self.stop()


func start_animation():
	self.visible = true
	self.play("Explosion")
	$Timer.start()
	
func stop_animation():
	self.visible = false
	self.stop()
	$Timer.stop()
	

func _on_Timer_timeout():
	stop_animation()
