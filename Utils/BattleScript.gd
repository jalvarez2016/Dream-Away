extends Node2D

var level_parameters
onready var pContainer = $PlayerContainer
onready var eContainer = $EnemiesContainer

func _ready():
	print(pContainer, eContainer)
	var players = level_parameters.players
	var enemies = level_parameters.enemies
	var counter = 0
	for player in players:
		counter += 1
		_create_player(player, counter)
	counter = 0
	for enemy in enemies:
		counter += 1
		_create_enemy(enemy, counter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _create_player(nodeData, index):
	var battlePlayer = load("res://Players/BattlePlayer.tscn").instance()
	var stats = battlePlayer.get_node("Stats")
	var sprite = battlePlayer.get_node("Sprite")
	var newSprite = load(nodeData.sprite)
	print(nodeData.sprite)
	
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
	battlePlayer.position = Vector2(20, (160/5) * index + 20)
	pContainer.add_child(battlePlayer)

func _create_enemy(nodeData, index):
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
	battleEnemy.position = Vector2(300, (150/5) * index)
	add_child(battleEnemy)
