const atk_lookup = [
	"res://specialatk.gd",	# 0
	"res://tattleatk.gd"	# 1
]


func get_atk_id(id):
	if id > atk_lookup.size() - 1:
		return
	return atk_lookup[id]
