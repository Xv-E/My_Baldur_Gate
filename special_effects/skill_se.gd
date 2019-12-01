extends Node2D

var animat_classes = []
var animat_class:AnimatedSprite
var animat_name

func _ready():
	for n in get_children():
		animat_classes.append(n.name)
		#n.connect("animation_finished",self,"_on_animation_finished")
		
#根据动画类型名字返回在skill_se下的位置
func get_animat_class(c):
	return get_child(animat_classes.find(c))

func set_animat(c,n):
	animat_class = get_child(animat_classes.find(c))
	animat_name = n

func play(gp):
	if animat_class && animat_name:
		animat_class.global_position = gp
		#用动画精灵的拷贝播放动画，满足同时在多地播放的需求
		var dp = animat_class.duplicate()
		add_child(dp)
		dp.connect("finish",self,"_on_animation_finished")
		dp.play(animat_name)

func _on_animation_finished(dp):
	remove_child(dp)
