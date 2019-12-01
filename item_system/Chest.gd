extends Node2D

class_name Chest

var itemlist = []
var radius = 0
func _ready():
	pass

func _on_Area2D_mouse_entered():
	global.target = self
	modulate = Color( 0.8, 1, 0.8, 1 )

func _on_Area2D_mouse_exited():
	global.target = null
	modulate = Color( 1, 1, 1, 1 )
