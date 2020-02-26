extends Node

func is_character(node):
	if node.get_script().resource_path=="res://character/Character.gd":
		return true
	return false
	
func is_same_script(a,b):
	if a.get_script().resource_path == b.get_script().resource_path:
		return true
	else:
		return false


	
