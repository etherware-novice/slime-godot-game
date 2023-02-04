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


func new_damage_num(damage, pos):
	var damage_instance = damage_num.instance()
	add_child(damage_instance)
	damage_instance.update_number(damage, pos)
	pass # Replace with function body.


func calculate_hp_bar(hp, maxhp, pos):
	var percent = min((float(hp) / float(maxhp) * 20), 19)
	var sections = round(percent)
	

	var newbar = $e_hpbar.duplicate(0)
	newbar.visible = true
	newbar.frame = int(sections)
	newbar.position = pos + Vector2(0, 30)
	newbar.show()
	add_child(newbar)
	$despawn.start()
	yield($despawn, "timeout")
	newbar.queue_free()

func game_over():
	$transition.visible = true
	$AnimationPlayer.play("fadeout")
	pass
