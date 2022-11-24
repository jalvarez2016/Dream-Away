extends Node2D

onready var turnManager = load("res://Utils/TurnManager.gd").new()
var playerNames = ["Seigi", "Player", "Lia"]
var level_parameters
var everyone = []
var turn_queue = []
var currentTurn
var restPosition
onready var pContainer = $PlayerContainer
onready var eContainer = $EnemiesContainer

class MyCustomSorter:
	static func sort_decending(a, b):
		if a.battleInfo.speed > b.battleInfo.speed:
			return true
		return false

func _ready():
	randomize()
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
	currentTurn = turn_queue.pop_front()
	_start_turn_sequence()

func _create_player(nodeData, index):
	var battlePlayer = load("res://Players/BattlePlayer.tscn").instance()
	var stats = battlePlayer.get_node("Stats")
	var sprite = battlePlayer.get_node("Sprite")
	var newSprite = load(nodeData.sprite)
	#Set individual player stats
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
	var action_selector = load("res://Utils/ActionSelctor/Action_Selector.tscn").instance()
	if currentTurn.name in playerNames:
		var currentTurnNode = pContainer.get_node(currentTurn.name)
		currentTurnNode.add_child(action_selector)
		restPosition = currentTurnNode.position
		currentTurnNode.position = Vector2(120, 100)

func _reset_position():
	if currentTurn.name in playerNames:
		var currentTurnNode = pContainer.get_node(currentTurn.name)
		currentTurnNode.position = restPosition

func _on_ally_turn_end():
	_sync_battle_info()
	_reset_position()
	
	if turn_queue.size() > 0:
		currentTurn = turn_queue.pop_front()
		if currentTurn.name in playerNames:
			_start_turn_sequence()
		else:
			_swap_turn()
	else:
		_set_turn_order(everyone)
		currentTurn = turn_queue.pop_front()
		if currentTurn.name in playerNames:
			_start_turn_sequence()
		else:
			_swap_turn()

func _on_enemy_turn_end():
	var players = get_tree().get_nodes_in_group('Ally')
	var selectedPlayer = players[randi() % players.size()]
	var selectedPlayerStats = selectedPlayer.get_node("Stats")
	var selectedPlayerDef = selectedPlayerStats.defense
	
	var currentTurnNode = eContainer.get_node(currentTurn.name)
	var enemyStats = currentTurnNode.get_node("Stats")
	var enemyAttackStat = enemyStats.attack
	var enemyStatus = enemyStats.status
	
	match enemyStatus:
		"STUN":
			currentTurnNode._change_turn()
			var isStillStunned = (randi() % 10) > 4
			if isStillStunned:
				currentTurnNode._set_status('')
#			Add stunned animation and with change turn function call
		_:
			currentTurnNode._attack_animation()
			var calculateDamage
			if (selectedPlayerDef * .8) > enemyAttackStat:
				calculateDamage = enemyAttackStat / 2
			else:
				calculateDamage = (enemyAttackStat - round(selectedPlayerDef * 0.8)) + (randi() % 5)

			selectedPlayerStats.hp = selectedPlayerStats.hp - calculateDamage
			#Player takes damage animation here

func _swap_turn():
	match turnManager.turn:
		0:
			turnManager.turn = turnManager.ENEMY_TURN
		1:
			turnManager.turn = turnManager.ALLY_TURN

func _end_battle():
	var world_scene = load("res://World.tscn").instance()
	world_scene.level_parameters = level_parameters
	get_node("../").add_child(world_scene)
	queue_free()

#	Data Syncing functions

func _update_turn_queue():
	var count = 0
	var updated_turn_queue = []

	while count < turn_queue.size():
		var currentCheck = turn_queue[count]
		if currentCheck.battleInfo.hp > 0:
			updated_turn_queue.append(currentCheck)
		count  = count + 1
	turn_queue = updated_turn_queue
	_check_win()

func _sync_battle_info():
	var players = get_node("PlayerContainer").get_children()
	var enemies = get_node("EnemiesContainer").get_children()
	
	for character in players:
		var playerName = character.get_name()
		
		# Traverse through turn_queue
		var index = 0
		while index < turn_queue.size():
			var queued_turn = turn_queue[index]
			if playerName == queued_turn.name:
				var stats = character.get_node("Stats")
				
				queued_turn.battleInfo.hp = stats.hp
				queued_turn.battleInfo.attack = stats.attack
				queued_turn.battleInfo.defense = stats.defense
				queued_turn.battleInfo.mp = stats.mp
				queued_turn.battleInfo.agility = stats.agility
				queued_turn.battleInfo.speed = stats.speed
			index += 1
	
	for character in enemies:
		var playerName = character.get_name()
		
		# Traverse through turn_queue
		var index = 0
		while index < turn_queue.size():
			var queued_turn = turn_queue[index]
			if playerName == queued_turn.name:
				var stats = character.get_node("Stats")
				
				queued_turn.battleInfo.hp = stats.hp
				queued_turn.battleInfo.attack = stats.attack
				queued_turn.battleInfo.defense = stats.defense
				queued_turn.battleInfo.mp = stats.mp
				queued_turn.battleInfo.agility = stats.agility
				queued_turn.battleInfo.speed = stats.speed
			index += 1
	_update_turn_queue()

func _check_win():
	var enemies = eContainer.get_children()
	
	var index = 0
	while index < enemies.size():
		var enemy = enemies[index]
		var enemyHp = enemy.get_node("Stats").hp
		index += 1
		if enemyHp > 0: return
	_end_battle()
