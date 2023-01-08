extends KinematicBody2D


export var enable_shooting=true
export var right_range=400.0
export var left_range=400.0
export var transition_speed=3
export var health: float = 100 setget set_health
export var uniqueName:  String = "Enemy"
export var intervalTime=3
export var ShootTime=0.7
export var movement = false


const FLOOR_NORMAL: = Vector2.UP
var _velocity:Vector2 = Vector2.ZERO
export var gravity:float = 3000
export var speed:Vector2 = Vector2(100.0,1000.0)

onready var init_location = self.position
var current_location = Vector2.ZERO
var right_going = true
var is_alive = true

export var deathParticle : PackedScene

signal enemy_died


func give_interval_time():
	$Laser.intervalTime=self.intervalTime
func give_shoot_time():
	$Laser.shootTime=self.ShootTime

func _ready():
	self.give_interval_time()  #give the laser its variable times.....
	self.give_shoot_time()
	
	if movement: $AnimatedSprite.play("walk")
	else : $AnimatedSprite.play("idle")
	
	$AnimatedSprite.flip_h = true
	right_going = true
#	set_physics_process(false)
#	set_process(false)
	_velocity.x = speed.x
	if enable_shooting : $Laser.visible = true
	else : $Laser.visible = false
		
	if right_going: $Laser.set_facing("right")
	else : $Laser.set_facing("left")
	
	if not movement : _velocity.x = 0
	

func _physics_process(delta: float) -> void:
	
	var collision_with_player = false
	
	_velocity.y += gravity * delta 
	
	if movement:
		var right_limit = init_location.x+right_range
		var left_limit = init_location.x-left_range
		if is_on_wall():
			
			#print(self.get_last_slide_collision().collider.name)
			if self.get_last_slide_collision().collider != null and not self.get_last_slide_collision().collider.name == "Player":
				_velocity.x *= -1.0
				$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
				right_going = not right_going	
				
			else : collision_with_player = true
				
		elif self.position.x >= right_limit:
			_velocity.x *= -1.0
			$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
			right_going = false
		elif self.position.x <= left_limit:
			_velocity.x *= -1.0
			$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
			right_going = true
	
		
	if collision_with_player:
		_velocity.y = move_and_slide(_velocity,FLOOR_NORMAL, false, 0).y
	else :
		_velocity.y = move_and_slide(_velocity,FLOOR_NORMAL).y
		
	if position.y > 5000 : kill()
	
func _process(delta):
	if right_going: $Laser.set_facing("right")
	else : $Laser.set_facing("left")

func set_health(value: float):
	health = value
	if health <= 0: kill()
	
func take_damage(value : float): set_health(health - value)

func kill(wait_time = 2.0):
	
	if not is_alive : return
	
	is_alive = false
	
	var _particle = deathParticle.instance()
	_particle.position = position
	_particle.rotation = rotation
	_particle.emitting = true
	
	get_tree().current_scene.add_child(_particle)
	self.visible = false
	emit_signal("enemy_died")

	queue_free()

func _on_Timer_timeout():
	pass # Replace with function body.
