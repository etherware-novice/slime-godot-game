extends KinematicBody2D

var speed = 200
var velocity = Vector2()
var ini
var userinput = false

var target  # delete ethis

var EASING = Tween.TRANS_QUART

signal attack(damage)
signal endturn

# Called when the node enters the scene tree for the first time.
func _ready():
	ini = position
#	tween.set_trans(Tween.TRANS_CUBIC)


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
	if not userinput:
		return
	if not Input.is_action_pressed("ui_right"):
		return
	userinput = false
	print("hello")
	
	$Tween.interpolate_property(self, "position",
		position, target, 1,
		EASING, Tween.EASE_IN_OUT)
	$Tween.start()
	$AnimatedSprite.animation = "walk"
	yield($Tween, "tween_completed")
	
	$AnimatedSprite.animation = "atk"
	yield($AnimatedSprite, "frame_changed")  # pisscode
	yield($AnimatedSprite, "frame_changed")
	yield($AnimatedSprite, "frame_changed")
	emit_signal("attack", 5)
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


func do_attack(target_pos):
	userinput = true
	target = target_pos
	pass # Replace with function body.

