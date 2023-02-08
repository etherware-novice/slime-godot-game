extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_inst = null
onready var default_selections = [$fight, $item, $run, $star]
onready var atk_index = load("res://atk_id.gd").new()

var in_sub = null
var selection

var enemylist = []
var special_attacks = []

func set_up(current_player, atks):
	special_attacks = atks
	print("setup")
	update_text(current_player)
	$selector._end()
	$AnimationPlayer.play("popup")
	yield($AnimationPlayer, "animation_finished")
	
func update_text(new_label):
	$"hp box/Label".text = new_label



func ui_init(player):
	player_inst = player
	for x in get_tree().get_nodes_in_group("enemies").duplicate():
		if x.targetable:
			enemylist.append(x)
	$selector._setup(default_selections)

func end_turn():
	player_inst = null
	enemylist.clear()
	top_menu()
	$selector._end()

func top_menu():
	if player_inst:
		update_text(player_inst.health_display_format())
	for x in get_tree().get_nodes_in_group("enemies"):
		x.clear_hp_bar()
		
	in_sub = null
	$selector._setup(default_selections)
	selection = null



func interpret_preview(choice):
	match in_sub:
		"fight":
			update_text(enemylist[choice].health_display_format())
		"special":
			update_text(enemylist[choice].health_display_format())
		null:
			update_text(player_inst.health_display_format())

func interpret_select(choice):
	if not in_sub:
		print("top menu")
		update_text(player_inst.health_display_format())
		match choice:
			0:
				in_sub = "fight"
				set_target_enemies()
			3:
				in_sub = "special_menu"
				$selectbox.visible = true
				#$selector._setup([$selectbox/active_line])
				selection = load(atk_index.get_atk_id(special_attacks[0])).new()
				$selectbox/activeline.text = selection.get_name()
			_:
				update_text(str(choice) + " is not implemented")
	else:
		match in_sub:
			"fight":
				var killed = enemylist[choice]
				player_inst.basic_attack(killed)
				end_turn()
			"special_menu":
				in_sub = "special"
				set_target_enemies()
			"special":
				$selectbox.visible = false
				var killed = enemylist[choice]
				player_inst.do_predef(selection, killed)
				end_turn()


func set_target_enemies():
	for x in enemylist:
		x.display_hp_bar()
	$selector._setup(enemylist)
	interpret_preview(0)
