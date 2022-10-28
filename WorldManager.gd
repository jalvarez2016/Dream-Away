extends Node2D

# Declare local paramaters to pass to battle scene
var isBattling = false
var level_parameters = {
	"players": [],
	"enemies": []
}

func _ready():
	var entitiesContainer = get_node("Entities Container").get_children()
	var player_names = {}
	var enemy_names = {}
	if level_parameters.players.size() > 0 || level_parameters.enemies.size() > 0:
		for player in level_parameters.players:
			player_names[player.name] = player

		for enemy in level_parameters.enemies:
			enemy_names[enemy.name] = enemy

		for character in entitiesContainer:
			print( player_names.keys())
			if character.get_name() in player_names.keys():
				print("repositioning player")
				character.position.x = player_names[character.get_name()].position.x
				character.position.y = player_names[character.get_name()].position.y
			else:
				if character.get_name() in enemy_names.keys():
					var characterHp = enemy_names[character.get_name()].battleInfo.hp
					print(characterHp)
					if characterHp <= 0:
						print("removing enemy")
						character.queue_free()
				else:
					print("WARNING WARNING WARNING: \n", character)

func _change_to_battle():
	var battle_scene = load("res://Utils/Battle.tscn").instance()
	battle_scene.level_parameters = level_parameters
	get_node("../").add_child(battle_scene)
	queue_free()

func _deconstruct_node(node):
	var stats = node.get_node("Stats")
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
		},
		"position": {
			"x": node.position.x,
			"y": node.position.y
		}
	}
	return nodeData
