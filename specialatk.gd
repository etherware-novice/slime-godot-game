extends Node

class_name specatk

# character id's needed to be active to run command
var required=[0]
var display_name="NULL ATK"
var cost=0

func do_attack(main):
	pass


# 0: dont display (not involved in attack)
# 1: display, grayed out (not every character is available)
# 2: display active (every char accounted for)
func check_eligable(source):
	var temp_required = required.duplicate()
	var self_id = temp_required.find(source.get_id())
	if self_id == -1:  # if the character checking isnt in required, then cancel
		return
	
	temp_required.pop_at(self_id)

	for x in get_tree().get_nodes_in_group("party").duplicate():
		var id = temp_required.find(x.get_id())
		if self_id != -1:
			temp_required.pop_at(id)
	
	if not temp_required.empty():
		return 1
	return 2
