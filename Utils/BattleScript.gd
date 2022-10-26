extends Node2D

onready var turnManager = load("res://Utils/TurnManager.gd").new()
var playerNames = ["Seigi", "Player", "Lia"]
var level_parameters
var everyone = []
var turn_queue = []
var currentTurn
onready var pContainer = $PlayerContainer
onready var eContainer = $EnemiesContainer

class MyCustomSorter:
	static func sort_decending(a, b):
		if a.battleInfo.speed > b.battleInfo.speed:
			return true
		return false

func _ready():
	var players = level_parameters.players
	var enemies = level_parameters.enemies
	var counter = 0
	for player in players:
		_create_player(player, counter)
		counter += 1
	counter = 0
	for enemy in enemies:
		_create_enemy(enemy, counter, enemies.size())
		counter += 1
		
	everyone.append_array(players)
	everyone.append_array(enemies)
	_set_turn_order(everyone)
	
	turnManager.connect("ally_turn_started", self, "_on_ally_turn_end")
	turnManager.connect("enemy_turn_started", self, "_on_enemy_turn_end")
	_start_turn_sequence()

func _create_player(nodeData, index):
	var battlePlayer = load("res://Players/BattlePlayer.tscn").instance()
	var stats = battlePlayer.get_node("Stats")
	var sprite = battlePlayer.get_node("Sprite")
	var newSprite = load(nodeData.sprite)
	
#	Set individual player stats
	battlePlayer.set_name(nodeData.name)
	stats.hp = nodeData.battleInfo.hp
	stats.attack = nodeData.battleInfo.attack
	stats.defense = nodeData.battleInfo.defense
	stats.mp = nodeData.battleInfo.mp
	stats.agility = nodeData.battleInfo.agility
	stats.speed = nodeData.battleInfo.speed
	sprite.texture = newSprite
	
#	Loading correct animations into AnimationPlayer
#	https://docs.godotengine.org/en/stable/classes/class_animationplayer.html#class-animationplayer-method-add-animation
#	https://stackoverflow.com/questions/73257252/how-do-i-programmatically-load-animations-in-godot-separating-animation-from-ar
	
#	Set individual player position
	battlePlayer.position = Vector2(50, 50 * index + 30)
	pContainer.add_child(battlePlayer)

func _create_enemy(nodeData, index, amount):
	var battleEnemy = load("res://Enemies/BattleEnemy.tscn").instance()
	var stats = battleEnemy.get_node("Stats")
	var sprite = battleEnemy.get_node("Sprite")
	var newSprite = load(nodeData.sprite)
	
#	Set individual player stats
	battleEnemy.set_name(nodeData.name)
	stats.hp = nodeData.battleInfo.hp
	stats.attack = nodeData.battleInfo.attack
	stats.defense = nodeData.battleInfo.defense
	stats.mp = nodeData.battleInfo.mp
	stats.agility = nodeData.battleInfo.agility
	stats.speed = nodeData.battleInfo.speed
	sprite.texture = newSprite
	
#	Set individual player position
	battleEnemy.position = Vector2(220, (120/amount + 2) * index + 60)
	eContainer.add_child(battleEnemy)

func _set_turn_order(characters):
	turn_queue.append_array(characters)
	turn_queue.sort_custom(MyCustomSorter, 'sort_decending')

func _start_turn_sequence():
	var action_selector = load("res://Utils/Action_Selector.tscn").instance()
	currentTurn = turn_queue.pop_front()
	if currentTurn.name in playerNames:
		var currentTurnNode = pContainer.get_node(currentTurn.name)
		currentTurnNode.add_child(action_selector)
		currentTurnNode.position = Vector2(120, 100)
		
func _on_ally_turn_end():
	print("enemy turn start")
	turnManager.turn = turnManager.ENEMY_TURN
	
func _on_enemy_turn_end():
	print("ally turn start")
#	Get all players
#	Pick one randomly
#	Do damage
#	Player takes damage animation here
#	turnManager.turn = turnManager.ALLY_TURN
	
