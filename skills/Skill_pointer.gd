extends Sprite

class_name Skill_pointer
#技能指示器

var is_able = false
var is_rotate = true
var is_move = false
#var activity_radius = 100
var parent

func _ready():
	parent = get_parent()

#随鼠标旋转,随鼠标移动，可开关
func _process(delta):
	var mose_position=get_global_mouse_position()
	if is_move:
		#if parent.global_position.distance_to(mose_position)<activity_radius:
		global_position = mose_position
		#else:
		#	global_position = parent.global_position + parent.global_position.direction_to(mose_position)*activity_radius

	if is_rotate:
		rotation = (mose_position-parent.global_position).angle()
		
#设置指示器图片，默认不偏移
func set_pointer_texture(picture:Texture,is_offset=false):
	texture=picture
	if is_offset:
		offset=Vector2(picture.get_size().y/2,0)