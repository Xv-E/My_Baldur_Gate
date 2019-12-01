extends Button

func _pressed():
	if Item_Manager.hero_ib:
		Item_Manager.close_ib(Item_Manager.hero_ib)
	else:
		Item_Manager.open_ib(1,global.choosed_heros[0])
		

