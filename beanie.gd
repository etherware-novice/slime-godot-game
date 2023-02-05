extends "res://player.gd"

var EASING = Tween.TRANS_QUART


func _ready():
	maxhp = 40
	ui_name = "BEANIE"
	#damageoffset = Vector2(-20, -50)
	._ready()



func basic_attack(target):
	var ini = position
	
	$Tween.interpolate_property(self, "position",
		position, target.position + Vector2(-100, 0), 1,
		EASING, Tween.EASE_IN_OUT)
	$Tween.start()
	$AnimatedSprite.animation = "walk"
	yield($Tween, "tween_completed")
	
	$AnimatedSprite.animation = "atk"
	yield($AnimatedSprite, "frame_changed")  # pisscode
	yield($AnimatedSprite, "frame_changed")
	yield($AnimatedSprite, "frame_changed")
	emit_signal("attack", 5)
	target._sub_hp(5)
	get_node("%BattleCam").screen_shake()
	yield($AnimatedSprite, "animation_finished")
	
	$Tween.interpolate_property(self, "position",
		position, ini, 1,
		EASING, Tween.EASE_IN_OUT)
	$Tween.start()
	$AnimatedSprite.animation = "walk"
	$AnimatedSprite.flip_h = true
	yield($Tween, "tween_completed")
	
	$AnimatedSprite.animation = "idle"
	$AnimatedSprite.flip_h = false
	
	emit_signal("endturn")


