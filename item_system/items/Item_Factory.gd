class_name Item_Factory

static func new_item(path):
	
	var file = File.new()
	if not file.file_exists(path):
		return
	file.open(path, File.READ)
	var item_data = JSON.parse(file.get_as_text()).get_result() 
	file.close()
	# 非法json字符串
	if !item_data:
		return
	
	var item
	if(item_data["type"]=="Equipment"):
		item = Equipment.new()
	elif(item_data["type"]=="Drug"):
		item = Drug.new()
	
	item.load_item_data(item_data)
	return item