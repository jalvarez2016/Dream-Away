extends Node2D

enum {
	ATTACK,
	SKILL,
	STYLE,
	ITEM,
	RUN
}
var actionTypes = [ATTACK, SKILL, STYLE, ITEM, RUN]
var actions
var current_action = actionTypes.pop_front()

func _ready():
	actions = get_node("Actions").get_children()

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector = input_vector.normalized()
	
	if input_vector.x > 0:
		_rotate_right()
	elif input_vector.x < 0:
		_rotate_left()

func _rotate_right():
	actionTypes.append(current_action);
	current_action = actionTypes.pop_front()
#	rotation logic and scaling

func _rotate_left():
	actionTypes.push_front(current_action)
	current_action = actionTypes.pop_back()
#	rotation logic and scaling
	pass
