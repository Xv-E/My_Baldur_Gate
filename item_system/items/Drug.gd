extends Item

class_name Drug

var effect:Effect

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

func load_item_data(path):
	var file = File.new()
	if not file.file_exists(path):
		return
	file.open(path, File.READ)
	var item_date =JSON.parse(file.get_as_text()).get_result() 
	file.close()
	# 非法json字符串
	if !item_date:
		return
	
	item_name = item_date["name"]
	item_icon = item_date["texture"]
	item_type = item_date["type"]
#
#	if item_date["attr"]:
#		attr = Attribute.new()
#		for i in item_date["attr"].keys():
#			attr.set(i,item_date["attr"][i])
#
#	if item_date["effect"]:
#		effect = Effect.new()
#		for i in item_date["effect"].keys():
#			if i != "buffs":
#				effect.set(i,item_date["effect"][i])
#			else:
#				for b in item_date["effect"]["buffs"]:
#					effect.buffs.append(load(buffs_path+b+".gd").new())
