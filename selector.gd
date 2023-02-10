extends Sprite

signal choice_made(choice)
signal choice_hover(choice)
signal cancelled

var next_input
var targets
var cur_selection

var lockposition
var lockmax 

func _ready():
	_end()

func _process(delta):
	if next_input:
		return
	if not visible:
		return
	if Input.is_action_just_pressed("ui_left"):
		next_input = "left"
	elif Input.is_action_just_pressed("ui_right"):
		next_input = "right"
	elif Input.is_action_just_pressed("ui_accept"):
		next_input = "select"
	elif Input.is_action_just_pressed("ui_cancel"):
		next_input = "cancel"


func _setup(targetlist, maximum = 4):
	if targetlist is Array:
		targets = targetlist
	else:
		lockposition = targetlist
		lockmax = maximum
			
	visible = true
	cur_selection = 0
	$input_delay.start()

func _pause():
	$input_delay.stop()

func _resume():
	$input_delay.start()

func _end():
	cur_selection = 0
	lockmax = 0
	targets = null
	lockposition = null
	visible = false
	$input_delay.stop()

func _on_input_delay_timeout():
	var maximum_index
	if lockposition:
		position = lockposition
		maximum_index = lockmax
	else:
		maximum_index = targets.size() - 1
		var selected_opt = targets[min(cur_selection, maximum_index)]
		if selected_opt:
			position = selected_opt.get_global_transform_with_canvas().get_origin() + Vector2(0, -80)
	
	match next_input:
		"left":
			if cur_selection > 0:
				cur_selection -= 1
			emit_signal("choice_hover", cur_selection)
		"right":
			if cur_selection < maximum_index:
				cur_selection += 1
			emit_signal("choice_hover", cur_selection)
		"select":
			emit_signal("choice_made", cur_selection)
		"cancel":
			emit_signal("cancelled")
	next_input = null
