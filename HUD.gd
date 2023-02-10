extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var damage_num = preload("res://damagenum.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.




func start_player_hp(init_label, atks):
	$PlayerHP.set_up(init_label, atks)

func update_player_hp(new_label):
	$PlayerHP.update_text(new_label)

func new_damage_num(damage, pos):
	var damage_instance = damage_num.instance()
	add_child(damage_instance)
	damage_instance.update_number(damage, pos)
	pass # Replace with function body.


func game_over(text = null):
	$transition.visible = true
	if text:
		$gameover.text = text
	$PlayerHP.visible = false
	$AnimationPlayer.play("fadeout")
	pass


func start_user_ui(player):
	$PlayerHP.ui_init(player)
