extends Panel

func _ready():
	rect_global_position=get_global_mouse_position()

func _on_VBoxContainer_resized():
	rect_size=$VBoxContainer.rect_size

func add_Button(button:Button):
	$VBoxContainer.add_child(button)

func _input(event):	
	if event is InputEventMouseButton :
		var m_p = get_local_mouse_position()
		if m_p.x<0 or m_p.y<0 or m_p.x>rect_size.x or m_p.y>rect_size.y:
			get_parent().remove_child(self)

func common_menu(item:Item):
	var vbc = $VBoxContainer
	var button
	if item is Equipment:
		button = Button.new()
		button.text = "equip"
		vbc.add_child(button)
		button.connect("pressed",item,"used")
		button = Button.new()
		button.text = "information"
		vbc.add_child(button)
		button = Button.new()
		button.text = "throw"
		vbc.add_child(button)
	elif item is Drug:
		button = Button.new()
		button.text = "use"
		vbc.add_child(button)
		button = Button.new()
		button.text = "information"
		vbc.add_child(button)
		button = Button.new()
		button.text = "throw"
		vbc.add_child(button)
