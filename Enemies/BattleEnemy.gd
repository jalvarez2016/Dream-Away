extends KinematicBody2D

onready var turnManager = load("res://Utils/TurnManager.gd").new()
onready var stats = $Stats
onready var animationPlayer = $Sprite/AnimationPlayer

func _take_damage(_amount: int):
	stats.hp -= _amount

func _attack_animation():
	animationPlayer.play("Attacking")
	
func _end_attack_animation():
	animationPlayer.play("Return_From_Attacking")

func _change_turn():
	get_node("../../")._swap_turn()
