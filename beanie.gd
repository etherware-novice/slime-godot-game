extends "res://character.gd"

var speed = 200
var velocity = Vector2()
var userinput = false

var target  # delete ethis

var EASING = Tween.TRANS_QUART


func _ready():
	maxhp = 40
	damageoffset = Vector2(-20, -50)
	._ready()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
#	if target == null:
#		return
#	velocity = position.direction_to(target) * speed
#	if position.distance_to(target) > 2:
#		velocity = move_and_slide(velocity)
#		return
#	
#	if not attacking:
#		emit_signal("attack")

func _process(delta):
	var ini = position
	
	if not userinput:
		return
	if not Input.is_action_pressed("ui_right"):
		return
	userinput = false
	print("hello")
	
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
	get_node("%HUD").screen_shake()
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


func do_attack():
	var target_pos = get_tree().get_nodes_in_group("enemies").duplicate()
	target_pos.shuffle()
	target_pos = target_pos.pop_front()
	
	userinput = true
	target = target_pos
	pass # Replace with function body.

func _sub_hp(damage):
	._sub_hp(damage)
	$AnimatedSprite.animation = "hurt"
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.animation = "idle"
