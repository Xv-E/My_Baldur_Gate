extends TextureButton

class_name SkillButton

var skill:Skill

func _ready():
	pass
	
func set_skill(s:Skill):
	skill = s
	texture_normal = skill.icon
#
#func _pressed():
#	skill.aim()
	
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			skill.aim()
			modulate = Color( 0.5, 0.5, 0.5, 1 )
		elif !event.pressed and event.button_index == 1:
			modulate = Color( 1, 1, 1, 1 )
		elif event.pressed and event.button_index == 2:
			pass
		elif !event.pressed and event.button_index == 2:
			pass
