extends Panel

var s_hbox
var p_hbox
var skillcontainer
var portraitcontainer
func _ready():
	global.connect("change_choose",self,"update_ui")
	skillcontainer = $skill_bar/skillcontainer
	portraitcontainer = $portrait_bar/portraitcontainer

	#$PortraitContainer.remove_child(hbox)
	#var hb = HBoxContainer.new()
	#$PortraitContainer.add_child(hb)

		
func update_ui():
	portraitcontainer.remove_child(p_hbox)
	p_hbox = HBoxContainer.new()
	portraitcontainer.add_child(p_hbox)
	for h in global.heros:
		var npr = NinePatchRect.new()
		npr.texture = h.portrait
		npr.rect_min_size = Vector2(60,60)
		p_hbox.add_child(npr)

	if global.choosed_heros.size()>1:
		$skill_bar.visible = false
	elif global.choosed_heros.size() == 1:
		$skill_bar.visible = true
		skillcontainer.remove_child(s_hbox)
		var s_hbox = HBoxContainer.new()
		skillcontainer.add_child(s_hbox)
		
		var c = global.choosed_heros[0]
		for s in c.skills:
			var sb = SkillButton.new()
			s_hbox.add_child(sb)
			sb.set_skill(s)