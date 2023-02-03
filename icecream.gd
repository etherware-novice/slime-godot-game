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
		queue_free()


func _update_hp(new_hp):
	hp = new_hp
	emit_signal("hp_update", hp, maxhp, position)

func _sub_hp(damage):
	_update_hp(hp - damage)
