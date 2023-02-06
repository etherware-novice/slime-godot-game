extends "res://character.gd"

func _ready():
	add_to_group("party")
	print("added to party")
	._ready()

func do_attack():
	get_node("%HUD").start_user_ui(self)
