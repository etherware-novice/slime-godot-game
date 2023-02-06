func get_char_id(id):
	var lookup = [
		"res://beanie.tscn",	# 0
		"res://tbee.tscn",		# 1
		"res://icecream.tscn"	# 2
	]
	if id > lookup.size() - 1:
		return
	return lookup[id]

func get_enemy_layout(id):
	var lookup = [
		[2, 2]	# 0
	]
	if id > lookup.size() - 1:
		return
	return lookup[id]
