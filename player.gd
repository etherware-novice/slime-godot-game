extends character

class_name player

func _ready():
	add_to_group("party")
	print("added to party")
	._ready()

func do_attack():
	get_node("%HUD").start_user_ui(self)

func _sub_hp(damage, unblock=false):
	var taken = damage
	var action = button_action_command()
	yield(get_tree().create_timer(0.2), "timeout")
	if action.resume() == 1 && not unblock:
		taken = round(taken * (1 / action_multiplier))
	._sub_hp(taken)
