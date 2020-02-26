class_name Effect

var buffs = []

var damage = 0 # 伤害
var heal = 0 # 治疗
var mana_re = 0 #回蓝

static func affect(c,e):
	for b in e.buffs:
		b.add_to(c)
	c.attr.attr_list["HP"] = c.attr.attr_list["HP"] - e.damage*(1-(c.attr.attr_list["DEF"]/100.0)) + e.heal
	if c.attr.attr_list["HP"]<0:
		c.attr.attr_list["HP"] = 0
