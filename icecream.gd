extends KinematicBody2D

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
	yield($AnimatedSprite, "animation_finished")
	hp = hp - dmg
	if(hp < 0):
		queue_free()
	$AnimatedSprite.animation = "idle"
