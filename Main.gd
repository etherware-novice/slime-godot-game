extends Node2D

signal do_attack(target_pos)


var turnorder = []
var turnindex = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$BattleCam.make_current()
	turnorder += get_tree().get_nodes_in_group("party")
	turnorder += get_tree().get_nodes_in_group("enemies")
	for x in turnorder:
		x.connect("endturn", self, "_endturn")
	next_turn()



func next_turn():
	var cache = get_tree().get_nodes_in_group("party") 
	for x in cache:
		if not x.active:
			cache.erase(x)
	
	if cache.empty():
		get_node("%HUD").game_over()
		return
	
	var nextchar = turnorder[turnindex]
	if nextchar.active:
		nextchar.do_attack()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _endturn():
	print("end turn")
	turnindex += 1
	if turnindex >= turnorder.size():
		turnindex = 0
	next_turn()

