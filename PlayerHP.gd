extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_inst = null
var cur_selection = 0
onready var default_selections = [$fight, $item, $run]

var selections

var next_input
var in_sub = false




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


func ui_init(player):
	player_inst = player
	cur_selection = 0


func _on_input_delay_timeout():
	if not player_inst:
		print("nul")
		return
	$selector.visible = true
	var maximum_index = selections.size() - 1
	var selected_opt = selections[min(cur_selection, maximum_index)]
	$selector.position = selected_opt.position + Vector2(0, -80)
	
	match next_input:
		"left":
			if cur_selection > 0:
				cur_selection -= 1
		"right":
			if cur_selection < maximum_index:
				cur_selection += 1
		"select":
			if not in_sub:
				in_sub = true
				
			
	
	next_input = null
	pass # Replace with function body.
