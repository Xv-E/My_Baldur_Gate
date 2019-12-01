extends Item

class_name Equipment

var attr:Attribute
var need:Attribute
var effect:Effect

enum equipment_type{
	weapon,
	helmet,
	armor,
	leggings,
	shoes,
	ring,
	necklace
	}
	
var eqm_type

func _init():
	attr = Attribute.new()
	need = Attribute.new()
	effect = Effect.new()

func used(character):
	character.equipments

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
	eqm_type = item_date["eqm_type"]
		
	#设置要求属性
	if item_date["need"]:
		for i in item_date["need"].keys():
			need.set(i,item_date["need"][i])
	
	#设置基本属性
	if item_date["attr"]:
		for i in item_date["attr"].keys():
			attr.set(i,item_date["attr"][i])
			
	#effect用于设置buff
	if item_date["effect"]:
		for i in item_date["effect"].keys():
			if i != "buffs":
				effect.set(i,item_date["effect"][i])
			else:
				for b in item_date["effect"]["buffs"]:
					effect.buffs.append(load(buffs_path+b+".gd").new())

