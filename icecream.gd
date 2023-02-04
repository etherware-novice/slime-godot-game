extends KinematicBody2D

signal hp_update(new_hp, max_hp, pos)
signal damage_num(damage, position)
signal endturn

signal attack(dmg)

var maxhp = 30
var hp

var active = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = maxhp


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_beanie_attack(dmg):
	_sub_hp(dmg)
	if(hp > 0):
		$AnimatedSprite.animation = "hurt"
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.animation = "idle"
	else:
		$AnimatedSprite.animation = "death"
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.animation = "deathhold"
		yield(get_tree().create_timer(5.0), "timeout")
		active = false
		queue_free()

func do_attack(bar):
	if(not active):
		emit_signal("end_turn")
		return
	
	var ini = position
	
	var player = get_node("/root/Main/beanie")
	var peak = player.position
	peak.x -= (float(peak.x) - float(position.x)) / 2
	peak.y -= 200
	
	$Tween.interpolate_property(self, "position",
		position, peak, 1.5,
		Tween.TRANS_QUART, Tween.EASE_IN)
	$Tween.start()
	$AnimatedSprite.animation = "attack_up"
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.animation = "attack_hold"
	yield($Tween, "tween_completed")
	$Tween.interpolate_property(self, "position",
		position, player.position, 1.5,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	$AnimatedSprite.animation = "attack_flip"
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.animation = "attack_hold"
	$AnimatedSprite.flip_v = true
	yield($Tween, "tween_completed")
	
	$AnimatedSprite.flip_v = false
	$AnimatedSprite.animation = "attack_squish"
	yield($AnimatedSprite, "animation_finished")
	
	$AnimatedSprite.animation = "idle"
	
	get_node("/root/Main").screen_shake()
	emit_signal("attack", 5)
	position = ini
	
	emit_signal("endturn")
	

func _update_hp(new_hp):
	hp = new_hp
	emit_signal("hp_update", hp, maxhp, position)

func _sub_hp(damage):
	_update_hp(hp - damage)
	emit_signal("damage_num", damage, position)
