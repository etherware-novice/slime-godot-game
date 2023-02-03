extends KinematicBody2D

signal hp_update(new_hp, max_hp, pos)

var maxhp = 30
var hp
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
	$AnimatedSprite.animation = "hurt"
	_sub_hp(dmg)
	yield($AnimatedSprite, "animation_finished")
	if(hp < 0):
		queue_free()
	$AnimatedSprite.animation = "idle"


func _update_hp(new_hp):
	hp = new_hp
	emit_signal("hp_update", hp, maxhp, position)

func _sub_hp(damage):
	_update_hp(hp - damage)
