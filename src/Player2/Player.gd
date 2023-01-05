extends KinematicBody2D

signal grounded_updated(is_grounded)

const UP_DIRECTION = Vector2.UP

export var speed = 800.0
export var jump_strength = 1000.0
export var double_jump_strength = 1200.0
export var maximum_jumps = 2
export var gravity = 4500
export var max_fall_speed = 10000

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


func _ready():
	$Collision.disabled = false
	is_alive = true

func _physics_process(delta):
	
	if Input.is_action_just_pressed("kill"):
		get_tree().quit()
	
		
	velocity.y += gravity * delta
	if velocity.y > max_fall_speed: velocity.y = max_fall_speed
	
	velocity.x = clamp(velocity.x, -speed, speed)
	
	if Input.is_action_pressed("right"):
		velocity.x += speed * delta
		facing = "right"
		
	elif Input.is_action_pressed("left"):
		velocity.x -= speed * delta
		facing = "left"
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)


	# States
	is_falling = velocity.y > 0.0 and not is_on_floor()
	is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()
	is_double_jumping = Input.is_action_just_pressed("jump") and (is_falling or is_jumping or not is_on_floor())
	is_jump_cancelled = Input.is_action_just_released("jump") and velocity.y < 0.0
	is_idling = is_on_floor() and not (Input.is_action_pressed("left") or Input.is_action_pressed("right"))
	is_running = is_on_floor() and (Input.is_action_pressed("left") or Input.is_action_pressed("right"))
	is_grounded = is_on_floor()
	
	
	
	#Jumps
	if is_jumping:
		jumps_made += 1
		velocity.y = -jump_strength
		
	elif is_double_jumping:
		jumps_made += 1
		if jumps_made <= maximum_jumps:
			velocity.y = -double_jump_strength
			shake_camera(0.2, 15, 20, 0)
			#$Explosion.start_animation()
			$Explosion2.start_animation()
			
	elif is_idling or is_running:
		jumps_made = 0
		
	
	#move
	velocity = move_and_slide(velocity, UP_DIRECTION)
	
	
	animiation()


	var was_grounded = is_grounded
	is_grounded = is_on_floor()
	
	if was_grounded == null || was_grounded != is_grounded:
		emit_signal("grounded_updated", is_grounded)
	


func shake_camera(duration = 0.2, frequency = 15, amplitude = 30, priority = 0):
	$Camera2D/ScreenShake.start(duration, frequency, amplitude, priority)


func animiation():
	if facing == "left": $AnimatedSprite.flip_h = false
	else : $AnimatedSprite.flip_h = true
	
	$AnimatedSprite.play("Idle")
	

func kill(wait_time = 2.0):
	
	if not is_alive : return
	
	is_alive = false
	
	var _particle = deathParticle.instance()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	
	get_tree().current_scene.add_child(_particle)
	self.visible = false

	yield(get_tree().create_timer(wait_time), "timeout")
	
	queue_free()
