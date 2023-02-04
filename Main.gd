extends Node2D

signal do_attack(target_pos)


var turnorder = []
var turnindex = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/Camera2D.make_current()
	turnorder += get_tree().get_nodes_in_group("party")
	turnorder += get_tree().get_nodes_in_group("enemies")
	for x in turnorder:
		x.connect("endturn", self, "_endturn")
	next_turn()



func next_turn():
	print("next turn")
	turnorder[turnindex].do_attack()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _endturn():
	print("end turn")
	turnindex += 1
	if turnindex >= turnorder.size():
		turnindex = 0
	next_turn()

