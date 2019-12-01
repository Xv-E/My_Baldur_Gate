extends Skill

class_name UD_skill
#非指向性技能

#左键释放技能，右键取消技能释放
func _unhandled_input(event):
	if sp.is_able and event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			global.mouse_state=1
			if s_owner.pre_action:
				s_owner.pre_action.interrupt()
			set_to(root_canvas.get_global_mouse_position())
			s_owner.set_pre_action(self)
		elif event.button_index == 2:
			pass
		remove_sp()

func set_to(t:Vector2):
	to = t
	
func get_to():
	return to
