extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_inst = null
var cur_selection = 0
onready var default_selections = [$fight, $item, $run]

var selections

var next_input
var in_sub = null


var menu_temp = []


func _ready():
	selections = default_selections

func set_up(current_player):
	print("setup")
	update_text(current_player)
	$AnimationPlayer.play("popup")
	yield($AnimationPlayer, "animation_finished")
	$input_delay.start()
	
func update_text(new_label):
	$"hp box/Label".text = new_label


func _process(delta):
	if next_input:
		return
	if Input.is_action_just_pressed("ui_left"):
		next_input = "left"
	elif Input.is_action_just_pressed("ui_right"):
		next_input = "right"
	elif Input.is_action_just_pressed("ui_accept"):
		next_input = "select"
	elif Input.is_action_just_pressed("ui_cancel"):
		next_input = "cancel"


func ui_init(player):
	player_inst = player
	cur_selection = 0

func end_turn():
	$selector.visible = false
	player_inst = null
	top_menu()

func top_menu():
	if player_inst:
		update_text(player_inst.health_display_format())
	for x in menu_temp:
		x.queue_free()
	menu_temp.clear()
		
	in_sub = null
	selections = default_selections
	cur_selection = 0


func _on_input_delay_timeout():
	if not player_inst:
		return
	$selector.visible = true
	var maximum_index = selections.size() - 1
	var selected_opt = selections[min(cur_selection, maximum_index)]
	$selector.position = selected_opt.get_global_transform_with_canvas().get_origin() + Vector2(0, -80)
	
	match next_input:
		"left":
			if cur_selection > 0:
				cur_selection -= 1
			interpret_preview()
		"right":
			if cur_selection < maximum_index:
				cur_selection += 1
			interpret_preview()
		"select":
			interpret_select()
		"cancel":
			top_menu()
			
	
	next_input = null
	pass # Replace with function body.


func interpret_preview():
	match in_sub:
		"fight":
			update_text(selections[cur_selection].health_display_format())
		null:
			update_text(player_inst.health_display_format())

func interpret_select():
	if not in_sub:
		print("top menu")
		update_text(player_inst.health_display_format())
		match cur_selection:
			0:
				selections = get_tree().get_nodes_in_group("enemies").duplicate()  # get list of enemies
				for x in selections:
					menu_temp.append(x.display_hp_bar(null))
				in_sub = "fight"
				interpret_preview()
			_:
				update_text(str(cur_selection) + " is not implemented")
	else:
		match in_sub:
			"fight":
				var killed = selections[cur_selection]
				player_inst.basic_attack(killed)
				end_turn()

	cur_selection = 0


