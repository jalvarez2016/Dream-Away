extends Node

#Attack data is structured as follows:
#
#Skills: [
#  {
#     name: String
#     level_required: Number
#     damage: Number
#	  targets: Number # -1 means attacks all enemies or heal all allies
#	  hurt_enemies: Boolean
#     mana: Number
#     effect: Effect Type (to be matched)
#  }
#]
#
# Effect types are the following:
# * HEAL
# * HEAL_DAMAGE (heals and damages)
# * SHIELD (creates shields to block enemy attacks)
# * REVIVE
# * ULTIMATE
# * STUN
# * FATIGUE
# * Null (just does damage)

#Style attack data is structured as follows:
#
#Style Attack: [
#  {
#     name: String
#     level_required: Number
#     damage: Number
#	  targets: Number # -1 means attacks all enemies or heal all allies
#	  hurt_enemies: Boolean
#     style_points: Number out of 100
#     effect: Effect Type (to be matched)
#  }
#]
#
# Effect types are the following:
# * STOCK
# * HEAL
# * HEAL_DAMAGE (heals and damages)
# * SHIELD (creates shields to block enemy attacks)
# * REVIVE
# * STUN
# * Null (just does damage)

var data = {
	"Player": {
		"skills": [
			{
				"name": "Fast Heal",
				"level_required": 0,
				"damage": 0,
				"targets": 1,
				"hurt_enemies": false,
				"mana": 10,
				"effect": "HEAL" 
			},
			{
				"name": "Heal Drain",
				"level_required": 0,
				"damage": 20,
				"targets": 1,
				"hurt_enemies": true,
				"mana": 10,
				"effect": "HEAL_DAMAGE"
			},
			{
				"name": "Barrier",
				"level_required": 0,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"mana": 12,
				"effect": "SHIELD" 
			},
			{
				"name": "Group Heal",
				"level_required": 8,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"mana": 18,
				"effect": "HEAL" 
			},
			{
				"name": "Revive",
				"level_required": 20,
				"damage": 0,
				"targets": 1,
				"hurt_enemies": false,
				"mana": 25,
				"effect": "REVIVE" 
			},
		],
		"style": [
			{
				"name": "Heath Stock",
				"level_required": 12,
				"damage": 0,
				"targets": 0,
				"hurt_enemies": false,
				"style_points": 80,
				"effect": "STOCK" 
			},
			{
				"name": "Drain Stock",
				"level_required": 12,
				"damage": 45,
				"targets": 0,
				"hurt_enemies": false,
				"style_points": 40,
				"effect": "STOCK" 
			},
			{
				"name": "Heathing Sunshine",
				"level_required": 12,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"style_points": 20,
				"effect": "HEAL" 
			},
			{
				"name": "Day of Rebirth",
				"level_required": 12,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"style_points": 60,
				"effect": "REVIVE" 
			},
		],
		"exp": 0,
		"level": 1,
		"status": "normal"
	},
	"Lia": {
		"skills": [
			{
				"name": "Shadow Hammer",
				"level_required": 0,
				"damage": 25,
				"targets": 1,
				"hurt_enemies": true,
				"mana": 10,
				"effect": "STUN" 
			},
			{
				"name": "Shadow Spear",
				"level_required": 5,
				"damage": 40,
				"targets": 1,
				"hurt_enemies": true,
				"mana": 15,
				"effect": null
			},
			{
				"name": "Pain Rain",
				"level_required": 5,
				"damage": 20,
				"targets": -1,
				"hurt_enemies": true,
				"mana": 15,
				"effect": "SHIELD" 
			},
			{
				"name": "Opaque Shield",
				"level_required": 10,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"mana": 18,
				"effect": "SHIELD" 
			}
		],
		"style": [
			{
				"name": "Eclipse",
				"level_required": 12,
				"damage": 80,
				"targets": -1,
				"hurt_enemies": true,
				"style_points": 80,
				"effect": null 
			},
			{
				"name": "Aegis Shield",
				"level_required": 12,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"style_points": 40,
				"effect": "SHIELD" 
			},
			{
				"name": "Devour",
				"level_required": 12,
				"damage": 100,
				"targets": -1,
				"hurt_enemies": true,
				"style_points": 90,
				"effect": null 
			},
		],
		"exp": 0,
		"level": 1,
		"status": "nomral"
	},
	"Seigi": {
		"skills": [
			{
				"name": "Shield Bash",
				"level_required": 0,
				"damage": 15,
				"targets": 1,
				"hurt_enemies": true,
				"mana": 0,
				"effect": "STUN" 
			},
			{
				"name": "Righteous Slash",
				"level_required": 0,
				"damage": 40,
				"targets": 1,
				"hurt_enemies": true,
				"mana": 5,
				"effect": null
			},
			{
				"name": "Iron Glaive",
				"level_required": 5,
				"damage": 60,
				"targets": -1,
				"hurt_enemies": true,
				"mana": 8,
				"effect": null 
			},
			{
				"name": "Dragons Rage",
				"level_required": 20,
				"damage": 160,
				"targets": -1,
				"hurt_enemies": true,
				"mana": 20,
				"effect": "FATIGUE"
			}
		],
		"style": [
			{
				"name": "BEAST ROAR",
				"level_required": 0,
				"damage": 80,
				"targets": -1,
				"hurt_enemies": true,
				"style_points": 80,
				"effect": "STUN" 
			},
			{
				"name": "Knights Judgement",
				"level_required": 18,
				"damage": 100,
				"targets": 1,
				"hurt_enemies": false,
				"style_points": 80,
				"effect": null 
			},
			{
				"name": "Vapor Strike",
				"level_required": 19,
				"damage": 100,
				"targets": -1,
				"hurt_enemies": true,
				"style_points": 90,
				"effect": null 
			},
		],
		"exp": 0,
		"level": 1,
		"status": "nomral"
	},
	"items": [
		{
			"name": "Healing Herb",
			"amount": 1,
		}
	]
}

var itemGlossary = {
	"Healing Herb" : {
			"name": "Healing Herb",
			"effect": "HEAL",
			"targets": 1,
			"heal_amount": 30,
			"info": "Heals one ally in the party by 30 health points",
			"icon": "res://Utils/Skill Icons/Skill_Attack_Icon.png"
	}
}
