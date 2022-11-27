extends Control

onready var itemTitle = $ItemName
onready var itemImg = $ItemImg
onready var itemAmount = $ItemAmount

func _set_item_data(
itemName = "Attack",
itemIcon = "res://Utils/Skill Icons/Skill_Attack_Icon.png",
amount = 1
):
	itemTitle.text = itemName
	itemImg.texture = load(itemIcon)
#	itemAmount.text = str(amount)
