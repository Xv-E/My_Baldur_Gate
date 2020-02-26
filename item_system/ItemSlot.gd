extends TextureRect

class_name ItemSlot

var r_menu = preload("res://item_system/menu.tscn")

var bar = null
var item = null
var item_icon = null
var square = preload("res://art/item/skil.png")
var id

func _ready():
	item_icon = TextureRect.new()
	#item_icon.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	add_child(item_icon)
	texture = square
	
func set_item(i):
	item = i
	if i:
		item_icon.texture = load(item.item_icon)
		item.item_owner = bar.b_owner
	else:
		item_icon.texture = null

func exchange_item(slot1,slot2):
	var l1 = slot1.bar.b_owner.itemlist
	var l2 = slot2.bar.b_owner.itemlist
	
	l2[slot2.id] = slot1.item
	l1[slot1.id] = slot2.item
	
	var temp = slot2.item
	slot2.set_item(slot1.item)
	slot1.set_item(temp)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			item_icon.modulate = Color( 0.5, 0.5, 0.5, 1 )
		elif !event.pressed and event.button_index == 1:
			var slot = Item_Manager.find_hover_slot()
			if slot and item:
				exchange_item(self,slot)
			item_icon.modulate = Color( 1, 1, 1, 1 )
		elif event.pressed and event.button_index == 2:
			if item:
				var rm = r_menu.instance()
				rm.common_menu(item)
				MainCanvas.add_child(rm)
		elif !event.pressed and event.button_index == 2:
			pass
