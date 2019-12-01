extends AnimatedSprite

signal finish(dp)

func _ready():
	connect("animation_finished",self,"_on_boom_animation_finished")

func _on_boom_animation_finished():
	emit_signal("finish",self)
