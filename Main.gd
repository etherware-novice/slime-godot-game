extends Node2D

signal do_attack(target_pos)


var turnorder = []
var turnindex = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.make_current()
	turnorder += [$beanie]
	turnorder += get_tree().get_nodes_in_group("enemies")
	next_turn()



func next_turn():
	print("next turn")
	var attack_pos = $icecream.position
	attack_pos.x -= 100
	turnorder[turnindex].do_attack(attack_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func screen_shake():
	var orig = $Camera2D.position
	var random = RandomNumberGenerator.new()
	random.randomize()
	$Camera2D/shake.start()
	
	var i = 0
	while i < 5:
		$Camera2D.position += Vector2(random.randi_range(-7, 7), random.randi_range(-7, 7))
		yield($Camera2D/shake, "timeout")
		i += 1
	
	$Camera2D/shake.stop()
	$Camera2D.position = orig
		


func _on_beanie_attack(dmg):
	screen_shake()


func _endturn():
	print("end turn")
	turnindex += 1
	if turnindex >= turnorder.size():
		turnindex = 0
	next_turn()

func _on_beanie_endturn():
	_endturn()
	pass # Replace with function body.

func _on_icecream_endturn():
	_endturn()
	pass # Replace with function body.


