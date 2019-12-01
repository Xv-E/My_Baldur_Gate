extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func _unhandled_key_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		pass

func _on_TextureButton_pressed():
	$TextureButton.hide()
