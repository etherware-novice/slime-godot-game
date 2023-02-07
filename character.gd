extends KinematicBody2D

signal attack(damage)
signal endturn

signal hp_update(hp, maxhp, position)
signal died(selfc)

var maxhp = 30
var hp
var ui_name = "null"

var active = true

var cached_damage_bar



# Called when the node enters the scene tree for the first time.
func _ready():
	hp = maxhp


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pre_turn():
	print("preturn")
	get_node("%HUD").update_player_hp(health_display_format())
	if active:
		do_attack()

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
	hud.update_player_hp(health_display_format())
	if hp <= 0:
		on_death()
		return
	$AnimatedSprite.animation = "hurt"
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.animation = "idle"


	

func on_death():
	emit_signal("died", self)
	active = false

func health_display_format():
	return ui_name + " " + str(hp) + " / " + str(maxhp)


