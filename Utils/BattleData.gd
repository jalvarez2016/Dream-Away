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
				"effect": "HEAL",
				"info": "Heals a single target"
			},
			{
				"name": "Heal Drain",
				"level_required": 0,
				"damage": 20,
				"targets": 1,
				"hurt_enemies": true,
				"mana": 10,
				"effect": "HEAL_DAMAGE",
				"info": "Drains health from an enemy and uses it to heal themselves."
			},
			{
				"name": "Barrier",
				"level_required": 0,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"mana": 12,
				"effect": "SHIELD",
				"info": "Creates shields for all allies."
			},
			{
				"name": "Group Heal",
				"level_required": 8,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"mana": 18,
				"effect": "HEAL",
				"info": "Heals all members in the party."
			},
			{
				"name": "Revive",
				"level_required": 20,
				"damage": 0,
				"targets": 1,
				"hurt_enemies": false,
				"mana": 25,
				"effect": "REVIVE",
				"info": "Revives a single party member."
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
				"effect": "STOCK",
				"info": "Adds health to a storage of health that can be used later for healing or damage."
			},
			{
				"name": "Drain Stock",
				"level_required": 12,
				"damage": 45,
				"targets": 1,
				"hurt_enemies": false,
				"style_points": 40,
				"effect": "STOCK",
				"info": "Drains health from an enemy and adds it to a storage of health that can be used later for healing or damage."
			},
			{
				"name": "Heathing Sunshine",
				"level_required": 12,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"style_points": 20,
				"effect": "HEAL",
				"info": "Uses the health stored in the health stock to heal all party members equally up to the amount in the health stock. Whatever is not used remains in the health stock for later use."
			},
			{
				"name": "Day of Rebirth",
				"level_required": 12,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"style_points": 60,
				"effect": "REVIVE",
				"info": "Resurrects all defeated party members at 50% health."
			},
		],
		"exp": 0,
		"level": 1,
		"status": "normal",
		"shield": 0
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
				"effect": "STUN",
				"info": "Slams a hammer conjured up with magic down on an enemy."
			},
			{
				"name": "Shadow Spear",
				"level_required": 5,
				"damage": 40,
				"targets": 1,
				"hurt_enemies": true,
				"mana": 15,
				"effect": null,
				"info": "Shoots a spear created with magic at an enemy."
			},
			{
				"name": "Pain Rain",
				"level_required": 5,
				"damage": 20,
				"targets": -1,
				"hurt_enemies": true,
				"mana": 15,
				"effect": "SHIELD",
				"info": "Rains down needles on all enemies while making making shields for your party."
			},
			{
				"name": "Opaque Shield",
				"level_required": 10,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"mana": 18,
				"effect": "SHIELD",
				"info": "Creates shields for all members of the party."
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
				"effect": null,
				"info": "Brings down a maasive ball of darkness on your enemies."
			},
			{
				"name": "Aegis Shield",
				"level_required": 12,
				"damage": 0,
				"targets": -1,
				"hurt_enemies": false,
				"style_points": 40,
				"effect": "SHIELD",
				"info": "Creates an impenetrable shield that lasts 5 rounds."
			},
			{
				"name": "Devour",
				"level_required": 12,
				"damage": 100,
				"targets": -1,
				"hurt_enemies": true,
				"style_points": 90,
				"effect": null,
				"info": "Lia consumes the nightmares of her enemies to fire up an attack that damages all enemies physically and psychologically."
			},
		],
		"exp": 0,
		"level": 1,
		"status": "nomral",
		"shield": 0
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
				"effect": "STUN",
				"info": "Slam into a single enemy with using a shield."
			},
			{
				"name": "Righteous Slash",
				"level_required": 0,
				"damage": 40,
				"targets": 1,
				"hurt_enemies": true,
				"mana": 5,
				"effect": null,
				"info": "Brings down a mighty sword slash against the enemy"
			},
			{
				"name": "Iron Glaive",
				"level_required": 5,
				"damage": 60,
				"targets": -1,
				"hurt_enemies": true,
				"mana": 8,
				"effect": null,
				"info": "Cleaves enemies with a magic enfused sword"
			},
			{
				"name": "Dragons Rage",
				"level_required": 20,
				"damage": 160,
				"targets": -1,
				"hurt_enemies": true,
				"mana": 20,
				"effect": "FATIGUE",
				"info":
					"Unleashes Seigi's rage on all enemies using as much magic to strengthen her blows as she can."
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
				"effect": "STUN",
				"info":
					"Unleashes a beastly roar that stuns all that hear it. Damages all enemies."
			},
			{
				"name": "Knights Judgement",
				"level_required": 18,
				"damage": 100,
				"targets": 1,
				"hurt_enemies": false,
				"style_points": 60,
				"effect": null,
				"info": "Unleashes a devastating sword slash on a single enemy."
			},
			{
				"name": "Vapor Strike",
				"level_required": 19,
				"damage": 100,
				"targets": -1,
				"hurt_enemies": true,
				"style_points": 90,
				"effect": null,
				"info": "A flurry of sword strikes rains down on all enemies."
			},
		],
		"exp": 0,
		"level": 1,
		"status": "nomral",
		"shield": 0
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
