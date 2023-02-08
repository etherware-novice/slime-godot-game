extends character

# if set, every turn it ticks down and passes turn
var recovery = 0

class_name player

func _ready():
	add_to_group("party")
	print("added to party")
	._ready()

func _pre_turn():
	if recovery:
		recovery -= 1
		emit_signal("endturn")
		return
	._pre_turn()

func do_attack():
	get_node("%HUD").start_user_ui(self)

func _sub_hp(damage, unblock=false):
	var taken = damage
	var action = button_action_command()
	yield(get_tree().create_timer(0.2), "timeout")
	if action.resume() == 1 && not unblock:
		taken = round(taken * (1 / action_multiplier))
	._sub_hp(taken)
