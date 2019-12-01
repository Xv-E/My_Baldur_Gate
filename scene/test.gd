extends Node2D

var character = preload("res://character/character.tscn")
var item_bar = preload("res://item_system/item_bar.tscn")
func _init_character():
	pass

func _ready():
#	var save_game = File.new()
#	save_game.open("user://savegame.save", File.WRITE)
#	save_game.store_line(to_json({"aaa":Strong}))
#	save_game.close()
		
#	var item = Item.new()
#	item.load_item_data("user://equipment/sword.json")
	
	var attribute = Attribute.new()
	for i in range(3):
		var c = character.instance()
		c.position = Vector2(i*300+100,100)
		c.attr = attribute
		c.Nav = $Navigation2D
		c.portrait = load("res://art/头像/"+str(i+1)+".jpg")
		add_child(c)
		global.heros.append(c)
		global.choosed_heros.append(c)
	global.ui.update_ui()
		#global.choosed_cs = [c]
#	for i in range(2):
#		var ib = item_bar.instance()
#		ib.position = Vector2(i*100,200)
#		MainCanvas.add_child(ib)
func remove_aa(aa):
	remove_child(aa)