extends KinematicBody2D


const UP_DIRECTION = Vector2.UP

export var speed = 1200.0
export var jump_strength = 1000.0
export var double_jump_strength = 800.0
export var maximum_jumps = 2
export var gravity = 4500
export var max_fall_speed = 10000



var jumps_made = 0
var velocity = Vector2.ZERO



func _physics_process(delta):
	
		
	velocity.y += gravity * delta
	
	if velocity.y > max_fall_speed: velocity.y = max_fall_speed
	
	
	velocity.x = clamp(velocity.x, -speed, speed)
	
	if Input.is_action_pressed("right"):
		velocity.x += speed * delta
	elif Input.is_action_pressed("left"):
		velocity.x -= speed * delta
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)


	# States
	var is_falling = velocity.y > 0.0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()
	var is_double_jumping = Input.is_action_just_pressed("jump") and is_falling
	var is_jump_cancelled = Input.is_action_just_released("jump") and velocity.y < 0.0
	var is_idling = is_on_floor() and is_zero_approx(velocity.x)
	var is_running = is_on_floor() and not is_zero_approx(velocity.x)
	
	
	#Jumps
	if is_jumping:
		jumps_made += 1
		velocity.y = -jump_strength
		
	elif is_double_jumping:
		jumps_made += 1
		if jumps_made <= maximum_jumps:
			velocity.y = -double_jump_strength
			
	elif is_idling or is_running:
		jumps_made = 0
		
	
	
	#move
	velocity = move_and_slide(velocity, UP_DIRECTION)
	
	
