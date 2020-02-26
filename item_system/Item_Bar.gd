extends Draw

class_name Item_Bar

#var slot_count = 72 # 格子数
var b_owner = null
var item_slots = []

func new_bar(bo,sc = 72):
	b_owner = bo

func _ready():
	pass
	
func set_col(col):
	$ViewportContainer/GridContainer.columns = col

func set_items(itemlist):
	for i in range(itemlist.size()):
		var item_slot = ItemSlot.new()
		item_slot.bar = self
		item_slot.id = i
		$ScrollContainer/GridContainer.add_child(item_slot)
		item_slots.append(item_slot)
		item_slots[i].set_item(itemlist[i])
	
func _on_close_pressed():
	Item_Manager.close_ib(self)
