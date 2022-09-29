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
var isBattling = false

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO && !isBattling:
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

func _on_PlayerBattleArea_area_entered(area):
	var parentNode = get_node("../")
	if area.find_parent("Enemy") && !isBattling:
		isBattling = !isBattling
		var allies = get_tree().get_nodes_in_group('Ally')
		var enemies = get_tree().get_nodes_in_group('Enemy')
		for player in allies:
			parentNode.level_parameters.players.append(parentNode._deconstruct_node(player))
			player.queue_free()
		for enemy in enemies:
			parentNode.level_parameters.enemies.append(parentNode._deconstruct_node(enemy))
			enemy.queue_free()
		parentNode._change_to_battle()
