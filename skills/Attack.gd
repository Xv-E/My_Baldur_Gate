extends D_skill

class_name Attack
#普通攻击
var T = preload("res://icon.png")

func _ready():
	cast_time = 0.8
	sp.set_pointer_texture(T)
	sp.is_move= true
	icon = preload("res://art/技能图标/00001.jpg")
	activity_radius = 50
	c_state = "cast"
	
func launch():
	effect.damage = s_owner.attr.ATK
	Effect.affect(to,effect)