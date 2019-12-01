extends TextureRect

class_name ItemSlot

var bar = null
var item = null
var item_icon = null
var square = preload("res://art/item/skil.png")


func _ready():
	item_icon = TextureRect.new()
	#item_icon.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	add_child(item_icon)
	texture = square
	
func set_item(i):
	item = i
	if i:
		item_icon.texture = item.item_icon
		item.position_in_bar = bar.item_slots.find(self)
	else:
		item_icon.texture = null

func exchange_item(slot1,slot2):
	var n1 = slot1.bar.b_owner
	var n2 = slot2.bar.b_owner
	n1.itemlist.remove(n1.itemlist.find(slot1.item))
	if slot2.item:
		n1.itemlist.append(slot2.item)
	n2.itemlist.remove(n2.itemlist.find(slot2.item))
	if slot1.item:
		n2.itemlist.append(slot1.item)
	var temp_item = slot2.item
	slot2.set_item(slot1.item)
	slot1.set_item(temp_item)
	
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			item_icon.modulate = Color( 0.5, 0.5, 0.5, 1 )
		elif !event.pressed and event.button_index == 1:
			var slot = Item_Manager.find_hover_slot()
			if slot:
				exchange_item(self,slot)
			item_icon.modulate = Color( 1, 1, 1, 1 )
		elif event.pressed and event.button_index == 2:
			pass
		elif !event.pressed and event.button_index == 2:
			pass
