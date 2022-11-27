extends HBoxContainer

onready var attackTitle = $AttackTitle/Name
onready var atttackIcon = $AttackTitle/Icon

onready var pointUse = $MpTitle/Mp
onready var pointIcon = $"MpTitle/MP Icon"

func _set_move_data(
attackName = "Attack",
attckIcon = "res://Utils/Skill Icons/Skill_Attack_Icon.png",
pointAmount = 5,
pointArgIcon = "res://Utils/Skill Icons/Skill_Attack_Icon.png"
):
	attackTitle.text = attackName
	pointUse.text = pointAmount
	
	atttackIcon.texture = load(attckIcon)
	pointIcon.texture = load(pointArgIcon)
