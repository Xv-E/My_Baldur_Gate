extends Control

class_name Draw

var holded = false
var click_position # 鼠标点击位置 拖动时用

func _on_close_pressed():
	pass
	
func _process(delta):
	# 拖动
	if holded:
		set_position(get_global_mouse_position()-click_position)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		click_position = get_local_mouse_position()
		holded = true
	elif event is InputEventMouseButton and !event.pressed and event.button_index == 1:
		holded = false

