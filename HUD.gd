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

func _on_icecream_hp_update(new_hp, max_hp, pos):
	print(new_hp)
	print(max_hp)
	var percent = min((float(new_hp) / float(max_hp) * 20), 19)
	var sections = round(percent)
	

	var newbar = $e_hpbar.duplicate(0)
	newbar.visible = true
	newbar.frame = int(sections)
	newbar.position = pos + Vector2(280, 240)
	newbar.show()
	add_child(newbar)
	print(newbar.position)
	print(sections)
	$despawn.start()
	yield($despawn, "timeout")
	newbar.queue_free()

func new_damage_num(damage, pos):
	var damage_instance = damage_num.instance()
	add_child(damage_instance)
	damage_instance.update_number(damage, pos)
	pass # Replace with function body.
	
func _on_icecream_damage_num(damage, pos):
	new_damage_num(damage, pos)



func _on_beanie_damage_num(damage, pos):
	new_damage_num(damage, pos)
