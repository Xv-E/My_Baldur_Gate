extends Node2D

class_name Skill
#技能 基类

signal cancel

var skill_se = preload("res://special_effects/skill_se.tscn")
var SE

var icon = preload("res://icon.png")

var timer:Timer
var cast_time = 3.0 # 读条时间
#var cast_times = 1 #施法次数
#var current_times = 0 #目前施法次数

var sp:Skill_pointer
var s_owner # 技能携带者
var root_canvas:Node2D # 技能item节点加载在这一节点下
var effect:Effect
var activity_radius = 100
var to

#var c_animation # 人物动画
#var s_animation # 技能特效
var c_state # 人物状态

func _ready():
	root_canvas = get_parent().get_parent() #默认是父节点（角色）的父节点
	
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout",self,"_launch")
	
	SE = skill_se.instance()
	root_canvas.add_child(SE)
	
	effect = Effect.new()
	sp=Skill_pointer.new()
	s_owner = get_parent()
	c_state = "cast"
	set_physics_process(false)

#判断释放条件
func allow_launch():
	if !to || activity_radius < global_position.distance_to(get_to()):
		return false
	else:
		return true

#读条
func cast():
	if timer.is_stopped():
		timer.start(cast_time)

#施放技能加进行一些内部处理
func _launch():
	launch()
	s_owner.set_state("stand") # 改成发送信号？？
		
#施放技能
func launch():
	pass

#打断
func interrupt():
	timer.stop()
	
#显示指示器 没指示器直接放的技能改写一下这个直接launch
func aim():
	global.mouse_state=1
	sp.is_able = true
	add_child(sp)
	
#指示器消失
func remove_sp():
	sp.is_able = false
	remove_child(sp)

func set_to(to):
	pass

func get_to():
	pass
	
