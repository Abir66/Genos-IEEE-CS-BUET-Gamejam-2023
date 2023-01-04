extends RayCast2D


var is_casting = false setget set_is_casting

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		self.is_casting = event.pressed



func _physics_process(delta):
	var cast_point = cast_to
	force_raycast_update()
	
	$CollisionParticles2D.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		$CollisionParticles2D.global_rotation = get_collision_normal().angle()
		$CollisionParticles2D.position = cast_point
		
	$Line2D.points[1] = cast_point
	$BeamParticles2D.position = cast_point * 0.5
	$BeamParticles2D.process_material.emission_box_extents.x = cast_point.length() * 0.5
	
	
	
func set_is_casting(cast):
	is_casting = cast
	
	$BeamParticles2D.emitting = is_casting
	$CastingParticles2D.emitting = is_casting
	if is_casting:
		appear()
	else:
		$CollisionParticles2D.emitting = false
		dissapear()
	
	
	set_physics_process(is_casting)
	

func appear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "Width", 0, 10.0, 0.2)
	$Tween.start()
	
func dissapear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "Width", 10.0, 0, 0.1)
	$Tween.start()
	
	
	
	
