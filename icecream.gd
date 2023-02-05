extends "res://character.gd"



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _ready():
	ui_name = "ICECREAM"
	maxhp = 10
	._ready()


func do_attack():	
	var ini = position
	
	var player = get_tree().get_nodes_in_group("party").duplicate()
	player.shuffle()
	player = player.pop_front()
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
		position, player.position + Vector2(0, -35), 1.5,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	$AnimatedSprite.animation = "attack_flip"
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.animation = "attack_hold"
	$AnimatedSprite.flip_v = true
	yield($Tween, "tween_completed")
	
	$AnimatedSprite.flip_v = false
	$AnimatedSprite.animation = "attack_squish"
	emit_signal("attack", 5)
	player._sub_hp(5)
	get_node("%BattleCam").screen_shake()
	yield($AnimatedSprite, "animation_finished")
	
	$AnimatedSprite.animation = "idle"
	
	position = ini
	
	emit_signal("endturn")
	

func _sub_hp(damage):
	._sub_hp(damage)
	display_hp_bar(5)
	get_node("%BattleCam").screen_shake()
	if active:
		$AnimatedSprite.animation = "hurt"
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.animation = "idle"

func on_death():
	.on_death()
	$AnimatedSprite.animation = "death"
	yield($AnimatedSprite, "animation_finished")
	remove_from_group("enemies")
	active = false
	$AnimatedSprite.animation = "deathhold"
	yield(get_tree().create_timer(5.0), "timeout")
	queue_free()
	

