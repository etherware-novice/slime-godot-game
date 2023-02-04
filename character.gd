extends KinematicBody2D

signal attack(damage)
signal endturn

signal hp_update(hp, maxhp, position)

var maxhp = 30
var hp

var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = maxhp


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func do_attack():
	emit_signal("endturn")


func _update_hp(new_hp):
	hp = new_hp
	emit_signal("hp_update", hp, maxhp, position)

func _sub_hp(damage):
	_update_hp(hp - damage)
	var hud = get_node("%HUD")
	var pos = get_global_transform_with_canvas().get_origin()

	hud.new_damage_num(damage, pos)
	hud.calculate_hp_bar(hp, maxhp, pos)
	if hp <= 0:
		on_death()

func on_death():
	active = false
 
