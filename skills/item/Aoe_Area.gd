extends Node2D

class_name Aoe_Area
#区域

signal AA_timeout(aa)

var SE

var timer:Timer
var effect:Effect
var area:Area2D
var area_shape:CollisionShape2D

var can_move = false
var owner_c
var enter_c = [] #进入过区域的character

var wait_time #触发间隔
var cur_times = 0  #触发了几次
var loop_times = 1 #总共触发这么多次
var last_time = 0.1 #一次触发持续时间

func _init():
	effect = Effect.new()
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout",self,"timeout")
	area = Area2D.new()
	#add_child(area)
	area_shape = CollisionShape2D.new()
	area.add_child(area_shape)
	area.connect("area_entered",self,"_getbody")


func _getbody(area:Area2D):
	var c = area.get_parent()
	if Classify.is_character(c) && enter_c.find(c)==-1:
		#Effect.affect(area.get_parent(),effect)
		Effect.affect(c,effect)
		enter_c.append(c)

func timeout():
	#持续时间结束remove area
	if area.get_parent():
		remove_child(area)
		timer.start(wait_time-last_time)
	#间隔时间到 重新add area	
	else:
		#如果有设置技能特效，则播放它
		if cur_times == loop_times:
			emit_signal("AA_timeout",self) #由上层进行回收
		else:
			cur_times += 1
			#重新检查触发
			add_child(area)
			if SE:
				SE.play(area.global_position)
			enter_c.clear()
			timer.start(last_time)


	
func set_Area(shape,gp):
	area_shape.shape = shape
	area.global_position = gp
	
func set_Timer(wait_t,loop_ts=1,last_t=0.1):
	wait_time = wait_t
	loop_times = loop_ts
	last_time = last_t
	timer.emit_signal("timeout")
	
func set_effect(e):
	effect = e