extends KinematicBody2D

enum {
	WANDER,
	CHASE
}
onready var stats = $Stats
var state = WANDER
var player = null
var WALK_SPEED = 80

func _can_see_Player():
	return player != null

func _on_can_see_player(area):
	if area.find_parent("Player"):
		player = area.find_parent('Player')
		state = CHASE

func _on_DetectionZone_area_exited(_area):
	player = null

func _physics_process(_delta):
	if _can_see_Player():
		match state:
			CHASE:
				var direction = (player.position - position).normalized()
				direction = move_and_slide(direction * WALK_SPEED)
			WANDER:
				pass
