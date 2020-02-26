extends UD_skill

class_name Cut
#技能 砍

var T = preload("res://icon.png")

func _ready():
	activity_radius=300
	# 设置技能特效
	SE.set_animat("boom","magic2")
	SE.scale = Vector2(0.5,0.5)
	#技能指示器
	icon = preload("res://art/技能图标/00007.jpg")
	sp.set_pointer_texture(T)
	sp.is_move= true
	#effect效果设置
	effect.damage = 10
	var strong = Strong.new()
	effect.buffs.append(strong)

func launch(node=null):
	var aa = Aoe_Area.new()
	root_canvas.add_child(aa)
	var cirs = CircleShape2D.new()
	cirs.radius = 30
	aa.SE = SE
	aa.set_effect(effect)
	aa.set_Area(cirs,get_to())
	aa.set_Timer(1,3)
	aa.connect("AA_timeout",root_canvas,"remove_aa")
