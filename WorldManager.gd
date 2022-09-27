extends Node2D


# Declare local paramaters to pass to battle scene
var players
var enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_PlayerBattleArea_area_entered(area):
	if area.find_parent("Enemy"):
		players = get_tree().get_nodes_in_group('player')
		enemies = get_tree().get_nodes_in_group('enemies')
		print([players, enemies])
		print("battle start")
#		transition to battle scene
	pass # Replace with function body.
