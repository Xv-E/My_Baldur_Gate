extends Navigation2D
#emm this is grandpa‘s
const SPEED = 200.0

var character = preload("res://character/character.tscn")
var xxx = 0
var current_np

func isometric_enlarge(d,v:PoolVector2Array):
	var vertices = v
	var pgsize=$Navins.navpoly.get_polygon_count()
	var angles = [] #记录内角
	var new_vertices = PoolVector2Array()
	for i in vertices.size():
		angles.append(0)
		new_vertices.append(Vector2(0,0))
		
	var size = vertices.size()
	var indexs = []
	for i in pgsize:
		var index = $Navins.navpoly.get_polygon(i)
		indexs.append(index)
		var idsize = index.size()
		for j in idsize:
			var a = vertices[index[(j+1)%idsize]].direction_to(vertices[index[j]])
			var b = vertices[index[j]].direction_to(vertices[index[(j-1)%idsize]])
			angles[index[j]] += a.angle_to(b)
			new_vertices[index[j]] += a + b
	#内角为优角的为凹点
	for i in new_vertices.size():
		if angles[i] < -3.141:
			new_vertices[i] = vertices[i] + 1/sin((3.14+angles[i])/2)*Vector2(0,0).direction_to(new_vertices[i].rotated(-3.14/2))*d
		else:
			new_vertices[i] = vertices[i] + 1/sin((3.14+angles[i])/2)*Vector2(0,0).direction_to(new_vertices[i].rotated(3.14/2))*d
	var to_del=[]
	
	for i in new_vertices.size():
		for j in range(i+1,new_vertices.size()):
			var a = new_vertices[i]-new_vertices[j]
			var b = vertices[i] - vertices[j]
			if a.x*b.x<0 || a.y*b.y<0:
				if to_del.find(i)==-1: 
					to_del.append(i)
				if to_del.find(j)==-1:
					to_del.append(j)
	var indexss = []
	
	for i in to_del:
		new_vertices.remove(new_vertices.size()-size+i)
		for j in indexs:
			var array = Array(j)
			if array.find(i)>-1:
				array.remove(array.find(i))
				if array.size()>2:
					indexss.append(PoolIntArray(array))
		
	return [new_vertices,indexs]

#放弃了。。
func fix_navpoly(d,navins:NavigationPolygonInstance):
	var v_i = isometric_enlarge(d,navins.navpoly.get_vertices())
	var vertices = v_i[0]
	var indexs = v_i[1]
	#清空多边形，添加变换后的多边形
	navins.navpoly.clear_polygons()
	navins.navpoly.set_vertices(vertices)
	for i in indexs.size():
		navins.navpoly.add_polygon(indexs[i])
	navins.enabled=false
	navins.enabled=true
	
func adjustPolygonPosition(node,inPolygon):
	var outPolygon = PoolVector2Array()
	for vertex in inPolygon:
		var finalPos =node.to_global(vertex)
		outPolygon.append(finalPos)
	return outPolygon

func add_terrain(d,vertices:PoolVector2Array):
	var size = vertices.size()	
	var new_vertices = PoolVector2Array()
	
	for i in size:
		var a = vertices[(i+1)%size].direction_to(vertices[i])
		var b = vertices[i].direction_to(vertices[(i-1)%size])
		if a.angle_to(b)>0:
			new_vertices.append(vertices[i] + (a-b)*d)
		else:
			new_vertices.append(vertices[i] - (a-b)*d)
	$Navins.navpoly.add_outline(new_vertices)
	$Navins.navpoly.make_polygons_from_outlines()
	$Navins.enabled=false
	$Navins.enabled=true
	
func cut_out(navins:NavigationPolygonInstance):
	var count = navins.navpoly.get_polygon_count()
	var vertices = navins.nabpoly.get_polygons()

func _ready():
	add_terrain(30,adjustPolygonPosition($Polygon2D,$Polygon2D.polygon))
	add_terrain(30,adjustPolygonPosition($Polygon2D2,$Polygon2D2.polygon))
	#fix_navpoly(-32,$Navins)
#	$Navins.enabled=false
#	$Navins.enabled=true
	var count = $Navins.navpoly.get_polygon_count()
	var indexs=[]
	for i in count:
		indexs.append($Navins.navpoly.get_polygon(i))
	var v = $Navins.navpoly.get_vertices()

#func _physics_process(delta):
#
#	#var space_state = get_world_2d().direct_space_state
#	for np in global.nps:
#		var path = np.path
#		if path.size() > 1:
#			var to_walk = delta * SPEED
#			while to_walk > 0 and path.size() >= 2:
#				var pfrom = path[0]
#				var pto = path[1]
#				var d = pfrom.distance_to(pto)
#				if d <= to_walk:
#					path.remove(0)
#					to_walk -= d
#				else:
#					path[0] = pfrom.linear_interpolate(pto, to_walk/d)
#					to_walk = 0
#			np.character.position = path[0]
#			#np.character.set_linear_velocity(path[0]-np.character.global_position)
#			#np.character.move_and_collide(path[0]-np.character.global_position)
#			#np.begin = np.character.position
#			#_update_path(np)
#			if path.size() < 2:
#				path = []

#func _update_path(np):
#	current_np.path = Array(get_simple_path(current_np.begin, current_np.end, true))
#	current_np = global.current_np
#	var r = Vector2(0,30)
#	var n = 18
#	var closest = INF
#	var angle = -INF
#	var dot_2 = true
#	for i in range(n):
#		r = r.rotated(6.28/n)
#		var p = Array(get_simple_path(current_np.begin+r, current_np.end+r, true))
#		if p.size()<3:continue
#		else: dot_2 = false
#		var d = p[1].distance_to(current_np.begin)
#		var a = abs((p[1]-p[0]).angle_to(p[2]-p[1]))
#		if d<closest||(d==closest&&a>angle):
#			closest = d
#			angle = a
#			current_np.path = [current_np.begin,p[1]-r*1.5]
#
#	if dot_2:
#		current_np.path = Array(get_simple_path(current_np.begin, current_np.end, true))
#
#func _unhandled_input(event):
#	current_np = global.current_np
#	if event is InputEventMouseButton and event.pressed and event.button_index == 2:
#		if !current_np.character.is_aim: 
#			current_np.begin = current_np.character.position 
#			current_np.end = get_local_mouse_position()-position
#			_update_path(current_np)
#		else:
#			current_np.character.is_aim=(current_np.character.is_aim+1)%2
#
		