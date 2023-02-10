const char_lookup = [
	"res://beanie.tscn",	# 0
	"res://tbee.tscn",		# 1
	"res://icecream.tscn",	# 2
	"res://enemybomb.tscn"	# 3
]

const enemy_layout_lookup = [
	[2],			# 0 one icecream
	[2],			# 1 one icecream, end of second turn death cutscene
	[2, 2],			# 2 two icecreams
	[2, 2, 3],		# 3 two icecreams and a bomb
	[2, 2, 2, 3]
]

func get_char_id(id):
	if id > char_lookup.size() - 1:
		return
	return char_lookup[id]

func get_enemy_layout(id):

	if id > enemy_layout_lookup.size() - 1:
		return
	return enemy_layout_lookup[id]

func get_layout_unique_data(mainnode):
	var maintree = mainnode.get_tree()
	var dialog = mainnode.get_node("Dialogue")
	var turncount = mainnode.turncount
	match mainnode.enemy_senario:
		1:
			print(turncount)
			if turncount != 2:
				return
			dialog.load_dialogue("test")
			yield(dialog, "dialog_close")
			yield(maintree.create_timer(2.0), "timeout")
			for x in maintree.get_nodes_in_group("enemies"):
				x._sub_hp(9999, true)
			yield(maintree.create_timer(3.0), "timeout")
			
