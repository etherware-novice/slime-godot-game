extends "res://character.gd"

func _ready():
	add_to_group("party")
	print("added to party")
	._ready()

func do_attack():
	$"%HUD".start_user_ui(self)
