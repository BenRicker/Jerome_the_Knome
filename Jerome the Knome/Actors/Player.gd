extends Actor

const MAX_SPEED = 60
const ACCELLERATION = 300
const FRICTION = 1000

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position", input_vector)
		animationTree.set("parameters/move/blend_position", input_vector)
		animationState.travel("move")
		_velocity = _velocity.move_toward(input_vector * MAX_SPEED, ACCELLERATION * delta)
	else:
		animationState.travel("idle")
		_velocity = _velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	_velocity = move_and_slide(_velocity)

