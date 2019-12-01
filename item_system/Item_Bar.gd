extends Node2D

class_name Item_Bar

var b_owner = null
var item_slots = []

func _ready():
	for i in range(72):
		var item_slot = ItemSlot.new()
		item_slot.bar = self
		$Panel/ScrollContainer/GridContainer.add_child(item_slot)
		item_slots.append(item_slot)
	
func set_col(col):
	$ViewportContainer/GridContainer.columns = col

func set_items(itemlist):
	for i in itemlist:
		item_slots[i.position_in_bar].set_item(i)
	
func _on_close_pressed():
	Item_Manager.close_ib(self)
