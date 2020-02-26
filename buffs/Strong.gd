extends Buff

class_name Strong


func _init():
	attr.attr_list["ATK"] = 10
	attr.attr_rate["ATK"]=0.2
	BE.set_animat("bling","circle1")
	
func apply(c):
	pass
#	BE.play()
#	timer.start(10)
#	c.update_attr()
#	set_timer(10)
#
#func relieve(character):
#	character.attr.ATK -= ATK_by_level[level]

#func add_logic(c):
#	for b in c.buffs:
#		if Classify.is_same_script(b,self):
#			if level>=b.level:
#				b.level = level
#				b.timer.start(10)
#				return
#	var dup = duplicate()
#	dup.apply(c)
#	dup.connect("buff_timeout",c,"remove_buff")
#	c.add_child(dup)
#	c.buffs.append(dup)
