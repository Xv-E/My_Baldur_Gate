extends Node

class_name Item

const buffs_path = "res://buffs/"
#var i_owner = null
var item_icon
var item_name
var item_type
var describe
var position_in_bar

var can_use = {
	"weapon":1,
	"helmet":1,
	"armor":1,
	"leggings":1,
	"shoes":1,
	"ring":1,
	"necklace":1,
	"potion":2,
	"material":0,
	"quest_item":0
}

func _init():
	item_icon = preload("res://art/item/A_Armour02.png")
	item_name = "niub"

func used(character):
	if can_use[item_type]==0:
		pass
	elif can_use[item_type]==1:
		pass
	elif can_use[item_type]==2:
		pass

