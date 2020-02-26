extends KinematicBody2D

class_name Character

var attack
var pick_item
var skills = []
var buffs = []
var pre_action:Skill# 预执行动作

var portrait # 头像
var radius
var id
var tb:TextureButton

var Nav:Navigation2D
var origin_attr:Attribute # 初始属性
var attr:Attribute # 属性
# state + _ + direct_face 为动画名
var state = "stand"
var direct_face = "down"

var is_choosed = false
var SPEED=200.0
var follow_node # 追寻的节点
var path = []
var begin = Vector2()
var end = Vector2()

var re_area = false
var area2d

var itemlist = Array()
# 装备
var equipments = {
	"weapon":null,
	"helmet":null,
	"armor":null,
	"leggings":null,
	"shoes":null,
	"ring":null,
	"necklace":null
}

#状态与动画
var state_animat={
	"run":"run",
	"stand":"stand",
	"cast":"attack",
	"attack":"attack"
}

func init_skills():
	pick_item = Pick_Item.new()
	skills.append(pick_item)
	add_child(pick_item)
	
	attack = Attack.new()
	skills.append(attack)
	add_child(attack)
	
	var s = Cut.new()
	skills.append(s)
	add_child(s)
	
func _ready():
	global.connect("change_choose",self,"is_choosed")
	
	radius = $Area2D/CollisionShape2D.shape.radius
	
	origin_attr = Attribute.new()
	origin_attr.basic_attr(null)
	attr = Attribute.new()
	attr.basic_attr(null)
	
	tb = $TextureButton
	init_skills()
	
	#之所以要换成area2d的拷贝是因为要进行remove+add触发area重新判断的骚操作 只有动态加入的可以如此..
	area2d = $Area2D.duplicate()
	area2d.connect("area_entered",self,"_on_Area2D_area_entered")
	area2d.connect("area_exited",self,"_on_Area2D_area_exited")
	add_child(area2d)
	remove_child($Area2D)
	
	itemlist.resize(72)
	for i in range(6):
		var item = Item_Factory.new_item("user://equipment/sword.json") #Item.new()
		#item.position_in_bar = i*2
		itemlist[i*2] = item
	
	$Polygon2D.scale = Vector2(0.8,0.8)
	$Polygon2D.modulate = Color( 0, 1, 1, 1 )
	
func update_bar():
	$visibale/bar/HP_bar.value = attr.attr_list["HP"]
	$visibale/bar/MP_bar.value = attr.attr_list["MP"]
	if pre_action:
		$visibale/bar/cast_bar.value  = (1-pre_action.timer.time_left/pre_action.cast_time)*100

#
#func remove_buff(buff):
#	var index = buffs.find(buff)
#	if index >=0:
#		#+buffs[index].relieve(self)
#		buffs.remove(index)
#		#remove_child(buff)
#	update_attr()

# 更新属性
func update_attr():
	var new_attr = Attribute.new()
	new_attr.duplicate(origin_attr)
	# HP MP 取当前值
	new_attr.attr_list["HP"] = attr.attr_list["HP"]
	new_attr.attr_list["MP"] = attr.attr_list["MP"]
	for e in equipments:
		if equipments[e]:
			new_attr.add(equipments[e].attr)
	for b in buffs:
		new_attr.add(b.attr)
	attr = new_attr.after_rate()

func set_pre_action(action,to=null):
	if pre_action:
		pre_action.interrupt()
		pre_action = null
		$visibale/bar/cast_bar.texture_under = null
		$visibale/bar/cast_bar.texture_progress = null
	if action:
		if to:
			action.to = to
		pre_action = action
		$visibale/bar/cast_bar.texture_under = pre_action.icon
		$visibale/bar/cast_bar.texture_progress = pre_action.icon
		path =Array(Nav.get_simple_path(global_position, pre_action.get_to(), true))

func set_state(new_state):
	if new_state == state:
		return
	if state == "cast" && pre_action!=attack:
		pre_action.interrupt()
		set_pre_action(null,null)
	state = new_state

# 人物面向
func head_to_point(to:Vector2,from=global_position):
	var direct = from.angle_to_point(to)
	var angle_in = 3.14/8
	if direct<angle_in*5 && direct>angle_in*3:
		direct_face = "up"
	elif direct<angle_in*3 && direct>angle_in:
		direct_face = "lu"
	elif direct<angle_in && direct>-angle_in:
		direct_face = "left"
	elif direct<-angle_in && direct>-angle_in*3:
		direct_face = "ld"
	elif direct<-angle_in*3 && direct>-angle_in*5:
		direct_face = "down"
	elif direct<-angle_in*5 && direct>-angle_in*7:
		direct_face = "rd"
	elif direct<-angle_in*7 || direct>angle_in*7:
		direct_face = "right"
	elif direct<angle_in*7 && direct>angle_in*5:
		direct_face = "ru"
		
func _process(delta):
	#记录当前状态
	var old_st = state
	var old_df = direct_face
	var ap = $AnimationPlayer.current_animation_position
	if pre_action:
		if pre_action.allow_launch():
			path.clear()
			head_to_point(pre_action.get_to())
			pre_action.cast()
			set_state(pre_action.c_state)

		#如果正在攻击不打断
#		elif state!="attack":
#			path =Array(Nav.get_simple_path(global_position, pre_action.get_to(), true))
#			state = "run"
			
	if path.size() > 1:
		var to_walk = delta * SPEED
		while to_walk > 0 and path.size() >= 2:
			var pfrom = path[0]
			var pto = path[1]
			var d = pfrom.distance_to(pto)
			head_to_point(path[1])
			if d <= to_walk:
				path.remove(0)
				to_walk -= d
			else:
				path[0] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		move_and_collide(path[0]-global_position)	
		#global_position = path[0]
		
	if path.size()>=2:
		set_state("run")
	if state == "run" && path.size() < 2:
		path = []
		set_state("stand")
	#根据状态面向播放动画
	$AnimationPlayer.play(state_animat[state]+"_"+direct_face)
	#如果只是换方向则接上一帧继续播放
	if state == old_st && direct_face !=old_df:
		$AnimationPlayer.advance(ap)
	
	update_bar()
		
func _unhandled_input(event):
	if !global.target and global.choosed_heros.find(self)!=-1 and event is InputEventMouseButton and event.pressed:
		if event.button_index == 2: 
			begin = global_position
			end = get_global_mouse_position()
			path =Array(Nav.get_simple_path(begin, end, true))
			follow_node = null
			set_state("run")
			set_pre_action(null)
	
func _on_Area2D_area_entered(area):
	if !Classify.is_character(area.get_parent()):
		return
	if path.size()>1:
		var d0 = end.distance_to(area.global_position)
		var d1 = global_position.distance_to(area.global_position)
		var d2 = path[0].direction_to(path[1])
		var d3 = global_position.direction_to(area.global_position)
		#global_position -= d3*(61-d1)
		#确定转弯方向
		if global_position.distance_to(end)>40:
			if d2.angle_to(d3)<0 :	
				path = Array(Nav.get_simple_path(global_position+(d3*28).rotated(3.14*9/16), end, true))
				path.insert(0,global_position)
			else:
				path = Array(Nav.get_simple_path(global_position+(d3*-28).rotated(3.14*7/16), end, true))
				path.insert(0,global_position)
		#如果是在终点有阻塞，调整终点
		if d0<d1:
			var rd =area.global_position.distance_to(end)
			path.pop_back()
			path.append(Nav.get_closest_point(end-d3*(62-rd)))
	

func _on_Timer_timeout():
	remove_child(area2d)
	add_child(area2d)
	
	#有指定目标则周期性的重新寻路
	if state!="cast" && pre_action:
		path =Array(Nav.get_simple_path(global_position, pre_action.get_to(), true))
		set_state("run")

func is_choosed():
	if global.choosed_heros.find(self)!=-1:
		$Polygon2D.scale = Vector2(0.8,0.8)
		$Polygon2D.modulate = Color( 0, 1, 1, 1 )
	else:
		$Polygon2D.scale = Vector2(0.73,0.73)
		$Polygon2D.modulate = Color(0, 1, 0.3, 1)

func _on_Area2D_mouse_entered():
	global.target = self
	modulate = Color( 0.8, 0.8, 1, 1 )

func _on_Area2D_mouse_exited():
	global.target = null
	modulate = Color( 1, 1, 1, 1 )
