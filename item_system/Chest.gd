extends Node2D

class_name Chest

var itemlist = Array()
var radius = 0
var count = 72

func _ready():
	itemlist.resize(count)
	pass

func _on_Area2D_mouse_entered():
	global.target = self
	modulate = Color( 0.8, 1, 0.8, 1 )

func _on_Area2D_mouse_exited():
	global.target = null
	modulate = Color( 1, 1, 1, 1 )
