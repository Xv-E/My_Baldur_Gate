extends D_skill

class_name Pick_Item
#拿东西 或者偷人身上的东西

var item_bar = preload("res://item_system/item_bar.tscn")
var T = preload("res://icon.png")

func _ready():
	cast_time = 0.1
	sp.set_pointer_texture(T)
	sp.is_move= true
	icon = preload("res://art/技能图标/00043.jpg")
	activity_radius = 80
	
	c_state = "cast"

func launch():
	Item_Manager.open_ib(0,to)
	Item_Manager.open_ib(1,global.choosed_heros[0])
	#s_owner.set_pre_action(null)
#	global.trade_ib = item_bar.instance()
#	MainCanvas.add_child(global.trade_ib)
#	#global.trade_ib.get_node("Panel/close").connect("pressed",self,"close_hero_ib")
#	global.trade_ib.position = Vector2(700,100)
#	global.trade_ib.set_items(to.itemlist)
