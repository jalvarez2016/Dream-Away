extends Node2D

onready var actionLabel = $ActionLabel
onready var infoContainer = $ScrollContainer
var battleData
enum {
	ACTION_SELECT,
	SKILL_SELECT,
	ENEMY_SELECT
}
var state = ACTION_SELECT

#Enemy variables
var enemies = []
var current_enemy
var enemyAnimationPlayer

#Action variables
var actions
var current_action

#Attack variables
var relevantStat

#Skill variables
var skillLabels = []
var currentSkill
var selectedSkillData

func _ready():
	battleData = get_node("/root/BattleData")
	randomize()
	actions = get_node("Actions").get_children()
	current_action = actions.pop_front()
	enemies = get_tree().get_nodes_in_group("BattleInstance")
	current_enemy = enemies.pop_front()
	enemyAnimationPlayer = current_enemy.get_node("Sprite").get_node("AnimationPlayer")

func _process(_delta):
	match state:
		ACTION_SELECT:
			if Input.is_action_just_pressed("ui_right"):
				_rotate_right()
			elif Input.is_action_just_pressed("ui_left"):
				_rotate_left()
				
			if Input.is_action_just_pressed("ui_action"):
		#		open currently selected actions' panels
				match current_action.get_name():
					"Attack":
						_attack_setup()
					"Skill":
						_skill_setup()
					"Style":
						enemyAnimationPlayer.play("Selecting")
						pass
					"Item":
						enemyAnimationPlayer.play("Selecting")
						pass
					"Run":
						pass
					_:
						print("Not an action")
				print("selected: ", current_action.get_name())

			elif Input.is_action_just_pressed("ui_back"):
				# go back to the selection and closing any opened panels
				pass
		SKILL_SELECT:
			if Input.is_action_just_pressed("ui_back"):
				state = ACTION_SELECT
				_depopulate_info()
				infoContainer.visible = false
			elif Input.is_action_just_pressed("ui_down"):
				_cycle_skills_down()
			elif Input.is_action_just_pressed("ui_up"):
				_cycle_skills_up()
			elif Input.is_action_just_pressed("ui_action"):
				infoContainer.visible = false
				enemyAnimationPlayer.play("Selecting")
				state = ENEMY_SELECT
		ENEMY_SELECT:
			if Input.is_action_just_pressed("ui_right"):
				_next_enemy()
			elif Input.is_action_just_pressed("ui_left"):
				_prev_enemy()
				
			if Input.is_action_just_pressed("ui_action"):
				match current_action.get_name():
					"Attack":
						_attack_action()
					"Skill":
						_skill_action()
			elif Input.is_action_just_pressed("ui_back"):
				# go back to the selection and closing any opened panels
				state = ACTION_SELECT
				enemyAnimationPlayer.play("RESET")
				_depopulate_info()
				pass
		_:
			print("Not a state")

func _rotate_right():
	var temp = {}
	
	for i in range(0, actions.size()):
		if i == 0 :
			var current = actions[i]
			var prev = current_action
			
			temp = {
				"position": current.position,
				"scale": current.scale,
				"z_index": current.z_index
			}
			
			current.position = prev.position
			current.scale = prev.scale
			current.z_index = prev.z_index
			
		else:
			var current = actions[i]
			var prev = temp
			
			temp = {
				"position": current.position,
				"scale": current.scale,
				"z_index": current.z_index
			}
			
			current.position = prev.position
			current.scale = prev.scale
			current.z_index = prev.z_index
	
	current_action.position = temp.position
	current_action.scale = temp.scale
	current_action.z_index = temp.z_index
		
	actions.push_back(current_action)
	current_action = actions.pop_front()
	_update_action_label(current_action.get_name())

func _rotate_left():
	var firstPos = actions[0].position
	var firstScale = actions[0].scale
	var firstIndex = actions[0].z_index
	
	for i in range(0, actions.size()):
		if i == actions.size() - 1:
			var current = actions[i]
			
			current.position = current_action.position
			current.scale = current_action.scale
			current.z_index = current_action.z_index
		else:
			var current = actions[i]
			var next = actions[i+1]
			
			current.position = next.position
			current.scale = next.scale
			current.z_index = next.z_index
			
	current_action.position = firstPos
	current_action.scale = firstScale
	current_action.z_index = firstIndex

	actions.push_front(current_action)
	current_action = actions.pop_back()
	_update_action_label(current_action.get_name())

func _cycle_skills_down():
	currentSkill.get_node("AnimationPlayer").play("RESET")
	skillLabels.push_back(skillLabels.pop_front())
	currentSkill = skillLabels[0]
	selectedSkillData = _get_skill_data(currentSkill.get_name())
	currentSkill.get_node("AnimationPlayer").play("Selecting")
	
func _cycle_skills_up():
	currentSkill.get_node("AnimationPlayer").play("RESET")
	skillLabels.push_front(skillLabels.pop_back())
	currentSkill = skillLabels[0]
	selectedSkillData = _get_skill_data(currentSkill.get_name())
	currentSkill.get_node("AnimationPlayer").play("Selecting")

func _update_action_label(updated_text):
	actionLabel.text = updated_text;

# Action setup methods are below
func _attack_setup():
#	Get character info
	var stats = get_node("../").get_node("Stats")
	relevantStat = stats.attack
	
	state = ENEMY_SELECT
	visible = false
	enemyAnimationPlayer.play("Selecting")

func _skill_setup():
	var stats = get_node("../").get_node("Stats")
	relevantStat = stats.attack
	var name = get_node("../").get_name()
	var skills = battleData.data[name].skills
	var lvl = battleData.data[name].level
	var count = 0;
	infoContainer.visible = true
	while count < skills.size() && skillLabels.size() < skills.size():
		var skillData = skills[count]
		if skillData.level_required <= lvl:
			var move = load("res://Utils/ActionSelctor/MoveSelect.tscn").instance()
			move.set_name(skillData.name)
			var moveName = move.get_node("AttackTitle").get_node("Name")
			moveName.text = skillData.name
			var mpAmount = move.get_node("MpTitle").get_node("Mp")
			mpAmount.text = str(skillData.mana)
			infoContainer.get_node("Info").add_child(move)
			skillLabels.push_back(move)
		count += 1
	currentSkill = skillLabels[0]
	selectedSkillData = _get_skill_data(currentSkill.get_name())
	currentSkill.get_node("AnimationPlayer").play("Selecting")
	state = SKILL_SELECT
	
func _get_skill_data(skill_name):
	var name = get_node("../").get_name()
	var skills = battleData.data[name].skills
	var count = 0
	var skillData
	while count < skills.size():
		if skills[count].name == skill_name:
			skillData = skills[count]
		count += 1
	return skillData

func _depopulate_info():
	var infoStuff = infoContainer.get_node("Info")
	var count = 0
	while count < infoStuff.get_children().size():
		infoStuff.get_children()[count].queue_free()
		count += 1
	skillLabels = []

# Enemy Cycling Logic
func _next_enemy():
	if enemies.size() == 0:
		pass
	else:
		enemies.push_back(current_enemy)
		current_enemy = enemies.pop_front()

func _prev_enemy():
	if enemies.size() == 0:
		pass
	else:
		enemies.push_front(current_enemy)
		current_enemy = enemies.pop_back()

# Action methods are below
func _attack_action():
	enemyAnimationPlayer.play("RESET")
	var enemyDefense = current_enemy.get_node("Stats").defense
	var damageDelt = relevantStat - (enemyDefense/ 1.5)
	current_enemy._take_damage(damageDelt + (randi() % 5))
	
#	Place enemy taking damage animation here
#	Check if enemy dead
	get_node("../../../")._on_ally_turn_end()
	queue_free()

func _skill_action():
	enemyAnimationPlayer.play("RESET")
	print(selectedSkillData)
#	Place enemy taking damage animation here
#	Check if enemy dead
#	get_node("../../../")._on_ally_turn_end()
#	queue_free()
