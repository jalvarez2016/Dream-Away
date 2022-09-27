extends KinematicBody2D

var velocity = Vector2.ZERO
var MAX_SPEED = 80
var ACCELERATION = 500
var FRICTION = 500
onready var animationPlayer = $AnimationPlayer

enum {
	IDLE,
	WALK,
	ATTACK,
	BLOCK,
	FAINT
}

var state = IDLE

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		state = WALK
	else:
		state = IDLE
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		WALK:
			
#			#animation logic
#			if input_vector.x > 0:
#				animationPlayer.play("LeftWalk")
#			else:
#				animationPlayer.play("RightWalk")
			
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		ATTACK:
			print("Attacking")
		BLOCK:
			print("blocking")
		FAINT:
			print("fainted")
	velocity = move_and_slide(velocity)

