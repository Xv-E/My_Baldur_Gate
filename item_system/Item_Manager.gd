extends Node

var item_bar = preload("res://item_system/item_bar.tscn")

var hero_ib = null  # 主角团的背包
var trade_ib = null  # 进行交换操作的背包

func close_ib(ib):
	if ib == hero_ib:
		hero_ib = null
	elif ib == trade_ib:
		trade_ib == null
		
	MainCanvas.remove_child(ib)

#1是主角团背包 0是交易背包
func open_ib(flag,node,itemlist=null):
	if itemlist==null:
		itemlist = node.itemlist
	var ib = item_bar.instance()
	ib.b_owner = node
	MainCanvas.add_child(ib)
	ib.set_items(itemlist)
	ib.b_owner = node
	if flag == 1:
		close_ib(hero_ib)
		hero_ib = ib
		ib.set_position(Vector2(700,100))
	elif flag == 0:
		close_ib(trade_ib)
		trade_ib = ib
		ib.set_position(Vector2(100,100))
	
func find_hover_slot():
	if hero_ib:
		for slot in hero_ib.item_slots:
			var slotMousePos = slot.get_local_mouse_position()
			var slotTexture = slot.texture
			if slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height():
				return slot
	if trade_ib:
		for slot in trade_ib.item_slots:
			var slotMousePos = slot.get_local_mouse_position()
			var slotTexture = slot.texture
			if slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height():
				return slot
	return null
