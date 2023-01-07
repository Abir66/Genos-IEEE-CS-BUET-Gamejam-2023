extends KinematicBody2D

signal grounded_updated(is_grounded)
signal set_charge(charge_value)
signal set_health(health_value)
signal player_died
signal invisible_tile_collision

const UP_DIRECTION = Vector2.UP

export var health: float = 100 setget set_health
export var charge: float = 0 setget set_charge
export var speed = 800.0
export var jump_strength = 1000.0
export var double_jump_strength = 1200.0
export var maximum_jumps = 2
export var gravity = 4500
export var max_fall_speed = 10000
export var double_jump_charge = 5
export var laser_charge_rate = 0.005

export var deathParticle : PackedScene

var jumps_made = 0
var velocity = Vector2.ZERO

#states
var is_falling = false
var is_jumping = false
var is_double_jumping = false
var is_jump_cancelled = false
var is_idling = false
var is_running = false
var is_grounded = false
var facing = "right"
var is_alive = false
var is_shooting_laser = false

var shooting_time_start : int

func _ready():
	set_charge(100)
	set_health(100)
	
	$IdleCollision.disabled = false
	$JumpCollision.disabled = true
	is_alive = true
	$Laser2.visible = true
	
func _physics_process(delta):
	
	if (is_on_wall() or is_on_floor() or is_on_ceiling()) and self.get_last_slide_collision().collider != null and self.get_last_slide_collision().collider.name == "Invisible":
		emit_signal("invisible_tile_collision")
	
	velocity.y += gravity * delta
	if velocity.y > max_fall_speed: velocity.y = max_fall_speed
	
	velocity.x = clamp(velocity.x, -speed, speed)
	
	if Input.is_action_pressed("right"):
		velocity.x += speed * delta
		facing = "right"
		if is_shooting_laser: $Laser2.change_facing(facing)
		
	elif Input.is_action_pressed("left"):
		velocity.x -= speed * delta
		facing = "left"
		if is_shooting_laser: $Laser2.change_facing(facing)
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)


	# States
	is_falling = velocity.y > 0.0 and not is_on_floor()
	is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()
	is_double_jumping = Input.is_action_just_pressed("jump") and (is_falling or is_jumping or not is_on_floor()) and charge >= double_jump_charge
	is_jump_cancelled = Input.is_action_just_released("jump") and velocity.y < 0.0
	is_idling = is_on_floor() and not (Input.is_action_pressed("left") or Input.is_action_pressed("right"))
	is_running = is_on_floor() and (Input.is_action_pressed("left") or Input.is_action_pressed("right"))
	is_grounded = is_on_floor()
		
	
	#sounds.................
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$jump.play()
		
	if Input.is_action_just_pressed("jump") and (is_falling or is_jumping)  and not is_on_floor() and charge >= double_jump_charge :
		$doubleJump.play()
		
	
	
	#Jumps
	if is_jumping:
		jumps_made += 1
		velocity.y = -jump_strength
		
	elif is_double_jumping:
		jumps_made += 1
		if jumps_made <= maximum_jumps:
			velocity.y = -double_jump_strength
			decrease_charge(double_jump_charge)
			shake_camera(0.2, 15, 20, 0)
			$Explosion.start_animation()
			
	elif is_idling or is_running:
		jumps_made = 0
	
	#move
	velocity = move_and_slide(velocity, UP_DIRECTION)
	
	animiation()
	if is_jumping or is_double_jumping:
		$IdleCollision.disabled = true
		$JumpCollision.disabled = false

	else :
		$IdleCollision.disabled = false
		$JumpCollision.disabled = true
		
		
	var was_grounded = is_grounded
	is_grounded = is_on_floor()
	
	if was_grounded == null || was_grounded != is_grounded:
		emit_signal("grounded_updated", is_grounded)
	
	
	#Laser
	if (Input.is_action_just_pressed("ShotTest") or Input.is_action_pressed("ShotTest")) and charge > 200 * laser_charge_rate:
		shake_camera(0.2, 15, 25, 0)
		if not is_shooting_laser:
			$Laser2.shoot_laser(facing) 
			is_shooting_laser = true
			shooting_time_start = Time.get_ticks_msec()
	
	if Input.is_action_just_released("ShotTest") or not Input.is_action_pressed("ShotTest"):
		if is_shooting_laser:
			$Laser2.stop_laser()
			is_shooting_laser = false
			deduce_laser_charge()
		
	if is_shooting_laser:
		var shooting_time_elapsed = Time.get_ticks_msec() - shooting_time_start
		if(shooting_time_elapsed > 100) : deduce_laser_charge()
		if charge < shooting_time_elapsed * laser_charge_rate:
			$Laser2.stop_laser()
			is_shooting_laser = false
			deduce_laser_charge()
				

func deduce_laser_charge():
	var shooting_time_elapsed = Time.get_ticks_msec() - shooting_time_start
	decrease_charge(shooting_time_elapsed * laser_charge_rate)
	shooting_time_start = Time.get_ticks_msec()


func shake_camera(duration = 0.2, frequency = 15, amplitude = 30, priority = 0):
	$Camera2D/ScreenShake.start(duration, frequency, amplitude, priority)


func animiation():
	
	if facing == "left": $AnimatedSprite.flip_h = false
	else : $AnimatedSprite.flip_h = true

	if is_jumping: $AnimatedSprite.play("Jump")
	elif is_running: $AnimatedSprite.play("Run")
	elif is_idling: $AnimatedSprite.play("Idle")
		

func kill(wait_time = 2.0):
	
	if not is_alive : return
	
	is_alive = false
	
	var _particle = deathParticle.instance()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	
	get_tree().current_scene.add_child(_particle)
	self.visible = false
	$IdleCollision.disabled = true
	$JumpCollision.disabled = true
	emit_signal("player_died")

	#yield(get_tree().create_timer(wait_time), "timeout")
	queue_free()

func set_charge(value: float):
	charge = value
	if charge < 0: charge = 0
	if charge > 100 : charge = 100
	emit_signal("set_charge", charge)
	
func set_health(value: float):
	health = value
	if health <= 0: kill()
	if health > 100 : health = 100
	emit_signal("set_health", health)
	
func decrease_charge(value: float): set_charge(charge - value)
func decrease_health(value : float): set_health(health - value)
	
func get_health() : return health
func get_charge() : return charge
func got_battery(charge) : 
	set_charge(self.charge + charge)

	
func _on_jump_finished():
	$jump.stop()


func _on_doubleJump_finished():
	$doubleJump.stop()
