extends Control

onready var itemTitle = $ItemName
onready var itemImg = $ItemImg

func _set_item_data(
itemName = "Attack",
itemIcon = "res://Utils/Skill Icons/Skill_Attack_Icon.png"
):
	itemTitle.text = itemName
	itemImg.texture = load(itemIcon)
