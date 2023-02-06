extends "res://character.gd"

func _ready():
	add_to_group("enemies")
	print("added to enemies")
	._ready()


func _sub_hp(damage):
	._sub_hp(damage)
	display_hp_bar(5)

func on_death():
	.on_death()
	$AnimatedSprite.animation = "death"
	yield($AnimatedSprite, "animation_finished")
	remove_from_group("enemies")
	active = false
	$AnimatedSprite.animation = "deathhold"
	yield(get_tree().create_timer(5.0), "timeout")
	queue_free()
	
