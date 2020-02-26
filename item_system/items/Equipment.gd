extends Item

class_name Equipment

var attr:Attribute
var need:Attribute
var effect:Effect

#enum equipment_type{
#	weapon,
#	helmet,
#	armor,
#	leggings,
#	shoes,
#	ring,
#	necklace
#	}
	
var eqm_type

func _init():
	attr = Attribute.new()
	need = Attribute.new()
	effect = Effect.new()

func used(character=item_owner):
	character.equipments[eqm_type] = self
	Effect.affect(character,effect)
	character.update_attr()
	
	
func load_item_data(item_data):
	item_name = item_data["name"]
	item_icon = item_data["texture"]
	item_type = item_data["type"]
	eqm_type = item_data["eqm_type"]
		
	#设置要求属性
	if item_data["need"]:
		for i in item_data["need"].keys():
			need.set(i,item_data["need"][i])
	
	#设置基本属性
	if item_data["attr"]:
		for i in item_data["attr"].keys():
			attr.set(i,item_data["attr"][i])
			
	#effect用于设置buff
	if item_data["effect"]:
		for i in item_data["effect"].keys():
			if i != "buffs":
				effect.set(i,item_data["effect"][i])
			else:
				for b in item_data["effect"]["buffs"]:
					effect.buffs.append(load(buffs_path+b+".gd").new())
					
