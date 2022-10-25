extends Node2D

export(int) var hp = 10
export(int) var attack = 10
export(int) var defense = 10
export(int) var mp = 10
export(int) var agility = 10
export(int) var speed = 10

var battle_actions := {
	"attacks": true,
	"magic": true,
	"item": true,
	"block": true,
	"run": true,
}
