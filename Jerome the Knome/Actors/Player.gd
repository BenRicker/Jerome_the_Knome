extends Actor

const MAX_SPEED = 100
const ACCELLERATION = 300
const FRICTION = 300

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		_velocity = _velocity.move_toward(input_vector * MAX_SPEED, ACCELLERATION * delta)
	else:
		_velocity = _velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_collide(_velocity * delta)

