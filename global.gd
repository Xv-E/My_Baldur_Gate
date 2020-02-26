extends Node2D

signal change_choose

var UI = preload("res://UI/UI.tscn")
var ui
var character = preload("res://character/character.tscn")
var screen_size
var heros = []
var choosed_heros = [] # 主角团选中角色
var mouse_state=0 # 0:正常 1:刚放完技能，不进行选择
var target #鼠标悬停的可选单体

var box_select = [null,null]

func _ready():
	ui= UI.instance()
	MainCanvas.add_child(ui)
	pass

func _process(delta):
	 update()

func _draw():
	if box_select[0]:
		draw_rect(Rect2(box_select[0],get_global_mouse_position()-box_select[0]),Color( 0.94, 0.97, 1, 1 ),false)
		
#处理鼠标选择事件
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if mouse_state == 1:
			mouse_state = 0
			return
		if event.button_index == 1:
			if target:
				if target is Character:
					choosed_heros = [target]
					emit_signal("change_choose")
			else:
				box_select[0] = get_global_mouse_position()
		if event.button_index == 2:
			if target: 
				if target is Character:
					for c in choosed_heros:
						c.set_pre_action(c.attack,target)
				elif target is Chest:
					for c in choosed_heros:
						c.set_pre_action(c.pick_item,target)
	#松开鼠标
	elif event is InputEventMouseButton and !event.pressed:
		#框选人物
		if event.button_index == 1:
			box_select[1] = get_global_mouse_position()
			if box_select[0]!=null:
				var c_h = []
				for h in heros:
					if point_in_box(h.global_position,box_select):
						c_h.append(h)
				if c_h.size()>0:
					choosed_heros = c_h
					emit_signal("change_choose")
				box_select = [null,null]

#内部函数，用于判断框选角色		
func point_in_box(p,b):
	var big
	var small
	if b[0].x>b[1].x:
		big = b[0].x
		small = b[1].x
	else:
		big = b[1].x
		small = b[0].x
	if p.x>big || p.x<small:
		return false
	if b[0].y>b[1].y:
		big = b[0].y
		small = b[1].y
	else:
		big = b[1].y
		small = b[0].y	
	if p.y<big && p.y>small:
		return true
		
