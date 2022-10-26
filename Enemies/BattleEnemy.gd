extends KinematicBody2D

onready var stats = $Stats

func _take_damage(_amount: int):
	print("taking this amount of damage: ", _amount)
	stats.hp -= _amount
