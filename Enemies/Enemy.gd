extends KinematicBody2D

enum {
	WANDER,
	CHASE
}

var state = WANDER
var player = null
var WALK_SPEED = 80


func _can_see_Player():
	return player != null

func _on_can_see_player(area):
	if area.find_parent("Player"):
		print("player object")
		player = area.find_parent('Player')
		state = CHASE

func _on_DetectionZone_area_exited(area):
	player = null
	print("exited")

func _physics_process(delta):
	if _can_see_Player():
		match state:
			CHASE:
				var direction = (player.position - position).normalized()
				direction = move_and_slide(direction * WALK_SPEED)
				pass
			WANDER:
				pass
				
