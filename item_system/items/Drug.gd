extends Item

class_name Drug

var effect:Effect

func used(character=item_owner):
	Effect.affect(character,effect)

func load_item_data(item_data):
	item_name = item_data["name"]
	item_icon = item_data["texture"]
	item_type = item_data["type"]
	
	#effect用于设置buff
	if item_data["effect"]:
		for i in item_data["effect"].keys():
			if i != "buffs":
				effect.set(i,item_data["effect"][i])
			else:
				for b in item_data["effect"]["buffs"]:
					effect.buffs.append(load(buffs_path+b+".gd").new())
