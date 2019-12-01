extends Node2D

var animat_names = []
var animat_class:AnimatedSprite
var animat_name

func _ready():
	for n in get_children():
		animat_names.append(n.name)
		
#根据动画类型名字返回在skill_se下的位置
func get_animat_class(c):
	return get_child(animat_names.find(c))

func set_animat(c,n):
	animat_class = get_child(animat_names.find(c))
	animat_name = n

func play():
	if animat_class && animat_name:
		animat_class.play(animat_name)
