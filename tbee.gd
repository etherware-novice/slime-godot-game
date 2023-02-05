extends "res://player.gd"

var EASING = Tween.TRANS_EXPO

func _ready():
	maxhp = 30
	ui_name = "BEE"
	._ready()

func basic_attack(target):
	var prop = $sword
	var screenoffset = Vector2(-100, -210)
	
	$AnimatedSprite.animation = "attack"
	yield($AnimatedSprite, "frame_changed")  # one day ill figure out how to do this
	yield($AnimatedSprite, "frame_changed")
	yield($AnimatedSprite, "frame_changed")
	
	
	prop.position = position + screenoffset
	prop.visible = true
	$Tween.interpolate_property(prop, "position",
		null, target.position + screenoffset, 0.5,
		EASING, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	$AnimatedSprite.animation = "idle"
	print(prop)
	prop.visible = false
	emit_signal("attack", 5)
	target._sub_hp(5)
	get_node("%BattleCam").screen_shake()
	
	emit_signal("endturn")
