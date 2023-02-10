extends KinematicBody2D

class_name character

signal attack(damage)
signal endturn

signal hp_update(hp, maxhp, position)
signal died(selfc)

var maxhp = 30
var hp
var ui_name = "null"

var attack = 5

var action_multiplier = 1.5

var active = true
var targetable = true

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


# make this read special attack id at some poit
func do_predef(x, target):
	x.do_attack(target)
	emit_signal("endturn")

func on_death():
	emit_signal("died", self)
	$AnimatedSprite.animation = "died"
	active = false
	targetable = false

func health_display_format():
	return ui_name + " " + str(hp) + " / " + str(maxhp)

# false for pressing at right time
# true for releasing button at right time
func button_action_command(reverse = false):
	var button_before = Input.is_action_pressed("ui_accept") == reverse
	yield()  # if the accept button is pressed in this timespan :D
	if button_before and (Input.is_action_pressed("ui_accept") != reverse):
		print("action command success")
		return 1

func get_id():
	var battle_id_lookup = load("res://battle_id.gd").new()
	var id = battle_id_lookup.char_lookup.find(filename)
	if id != -1:
		return id
