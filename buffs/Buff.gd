#extends Node
class_name Buff

signal buff_timeout(buff)

var attr:Attribute
var buff_se = preload("res://special_effects/buff_se.tscn")
var BE # 特效

var timer:Timer

var time = 10
var level = 1 # 等级
var stack = 1 # 层数

func _init():
	attr = Attribute.new()
	BE =buff_se.instance()
	timer = Timer.new()
	timer.one_shot = true
	
# 特殊效果
func apply(c):
	pass

# 处理加入buff的逻辑 叠加还是覆盖等等
#func add_logic(c):
#	for b in c.buffs:
#		if Classify.is_same_script(b,self):
#			# 等级大于则覆盖
#			if level>=b.level:
#				b.remove_from(c)
#			else:
#				return

func add_to(c):
	for b in c.buffs:
		if Classify.is_same_script(b,self):
			# 等级大于则覆盖
			if level>=b.level:
				b.remove_from(c)
			else: 
				return
	c.add_child(timer)
	c.add_child(BE)
	timer.connect("timeout",self,"remove_from",[c])
	
	c.buffs.append(self)	
	BE.play() # 播放buff动画
	timer.start(time)
	c.update_attr()
	apply(c)
	
func remove_from(c):
	var index = c.buffs.find(self)
	if index >= 0:
		c.buffs.remove(index)
	c.remove_child(timer)
	c.remove_child(BE)
	c.update_attr()
	
