extends Skill

class_name D_skill
#指向性技能

#判断释放条件
func allow_launch():
	if !to || activity_radius+to.radius <= global_position.distance_to(get_to()):
		return false
	else:
		return true

#施放技能
func launch():
	Effect.affect(to,effect)
		
#左键释放技能，右键取消技能释放
func _unhandled_input(event):
	if sp.is_able and event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			if global.target:
				if s_owner.pre_action:
					s_owner.pre_action.interrupt()
				set_to(global.target)
				s_owner.set_pre_action(self)
#				s_owner.pre_action = self
		elif event.button_index == 2:
			pass
		remove_sp()

func set_to(t:Node2D):
	to = t

func get_to():
	return root_canvas.to_global(to.global_position)
