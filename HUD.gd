extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var damage_num = load("res://damagenum.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		pass


func start_player_hp(init_label):
	$PlayerHP.set_up(init_label)

func update_player_hp(new_label):
	$PlayerHP.update_text(new_label)

func new_damage_num(damage, pos):
	var damage_instance = damage_num.instance()
	add_child(damage_instance)
	damage_instance.update_number(damage, pos)
	pass # Replace with function body.


func calculate_hp_bar(hp, maxhp, pos, delay = null):
	var percent = min((float(hp) / float(maxhp) * 20), 19)
	var sections = round(percent)
	

	var newbar = $e_hpbar.duplicate(0)
	newbar.visible = true
	newbar.frame = int(sections)
	newbar.position = pos + Vector2(0, 50)
	newbar.show()
	add_child(newbar)
	if delay:
		yield(get_tree().create_timer(delay), "timeout")
		newbar.queue_free()
	else:
		return newbar

func game_over(text):
	$transition.visible = true
	if text:
		$gameover.text = text
	$PlayerHP.visible = false
	$AnimationPlayer.play("fadeout")
	pass


func start_user_ui(player):
	$PlayerHP.ui_init(player)
