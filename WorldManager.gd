extends Node2D

# Declare local paramaters to pass to battle scene
var isBattling = false
var level_parameters := {
	"players": [],
	"enemies": []
}

func _change_to_battle():
	var battle_scene = load("res://Utils/Battle.tscn").instance()
	battle_scene.level_parameters = level_parameters
	get_node("../").add_child(battle_scene)
	queue_free()

func _deconstruct_node(node):
	var stats = node.get_node("Stats")
	print(node)
	var nodeName = node.get_name()
	var nodeSprite = node.get_node("Sprite").texture.resource_path
	var nodeData = {
		"name": nodeName,
		"sprite": nodeSprite,
		"battleInfo": {
			"hp": stats.hp,
			"attack": stats.attack,
			"defense": stats.defense,
			"mp": stats.mp,
			"agility": stats.agility,
			"speed": stats.speed
		}
	}
	return nodeData
