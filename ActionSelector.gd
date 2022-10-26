extends Node2D

onready var actionLabel = $ActionLabel
enum {
	ATTACK,
	SKILL,
	STYLE,
	ITEM,
	RUN
}
var actions
var current_action

func _ready():
	actions = get_node("Actions").get_children()
	current_action = actions.pop_front()

func _process(_delta):
	
	if Input.is_action_just_pressed("ui_right"):
		_rotate_right()
	elif Input.is_action_just_pressed("ui_left"):
		_rotate_left()
		
	if Input.is_action_just_pressed("ui_action"):
#		open currently selected actions' panels
		pass
	elif Input.is_action_just_pressed("ui_back"):
		# go back to the selection and closing any opened panels
		pass

func _rotate_right():
	var temp = {}
	
	for i in range(0, actions.size()):
		if i == 0 :
			var current = actions[i]
			var prev = current_action
			
			temp = {
				"position": current.position,
				"scale": current.scale,
				"z_index": current.z_index
			}
			
			current.position = prev.position
			current.scale = prev.scale
			current.z_index = prev.z_index
			
		else:
			var current = actions[i]
			var prev = temp
			
			temp = {
				"position": current.position,
				"scale": current.scale,
				"z_index": current.z_index
			}
			
			current.position = prev.position
			current.scale = prev.scale
			current.z_index = prev.z_index
	
	current_action.position = temp.position
	current_action.scale = temp.scale
	current_action.z_index = temp.z_index
		
	actions.push_back(current_action)
	current_action = actions.pop_front()
	_update_action_label(current_action.get_name())

func _rotate_left():
	var firstPos = actions[0].position
	var firstScale = actions[0].scale
	var firstIndex = actions[0].z_index
	
	for i in range(0, actions.size()):
		if i == actions.size() - 1:
			var current = actions[i]
			var next = actions[0]
			
			current.position = current_action.position
			current.scale = current_action.scale
			current.z_index = current_action.z_index
		else:
			var current = actions[i]
			var next = actions[i+1]
			
			current.position = next.position
			current.scale = next.scale
			current.z_index = next.z_index
			
	current_action.position = firstPos
	current_action.scale = firstScale
	current_action.z_index = firstIndex

	actions.push_front(current_action)
	current_action = actions.pop_back()
	_update_action_label(current_action.get_name())

func _update_action_label(updated_text):
	actionLabel.text = updated_text;
	pass
