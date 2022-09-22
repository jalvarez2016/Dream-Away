extends KinematicBody2D

enum {
	WANDER,
	CHASE
}

var state = WANDER

func _process(delta):
	pass


func _on_can_see_player(area):
	print("player entered area")
	print(area)
