class_name Attribute

# 属性列表
var attr_list
# 增幅比例
var attr_rate

# 初始化属性
func _init():
	attr_list = {
		"MAX_HP":0,
		"HP":0,
		"MAX_MP":0,
		"MP":0,
		"ATK":0,
		"DEF":0
	}

	attr_rate = {
		"MAX_HP":0,
		"HP":0,
		"MAX_MP":0,
		"MP":0,
		"ATK":0,
		"DEF":0
	}

# 属性加法
func add(a:Attribute,rate=1):
	for i in attr_list:
		attr_list[i] += a.attr_list[i]*rate
		attr_rate[i] += a.attr_rate[i]*rate


func after_rate():
	for i in attr_list:
		attr_list[i] = attr_list[i]*(1+attr_rate[i])
		attr_rate[i] = 0
	return self

func duplicate(a):
	attr_list = a.attr_list.duplicate()
	attr_rate = a.attr_rate.duplicate()
	
func basic_attr(race):
	attr_list = {
		"MAX_HP":100,
		"HP":100,
		"MAX_MP":100,
		"MP":100,
		"ATK":10,
		"DEF":10
	}
	
