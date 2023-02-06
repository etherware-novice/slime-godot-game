const char_lookup = [
	"res://beanie.tscn",	# 0
	"res://tbee.tscn",		# 1
	"res://icecream.tscn"	# 2
]

const enemy_layout_lookup = [
	[2, 2]	# two icecreams
]

func get_char_id(id):
	if id > char_lookup.size() - 1:
		return
	return char_lookup[id]

func get_enemy_layout(id):

	if id > enemy_layout_lookup.size() - 1:
		return
	return enemy_layout_lookup[id]
