extends Node2D

signal do_attack(target_pos)


var turnorder = []


var battle_id_lookup

# Called when the node enters the scene tree for the first time.
func _ready():
	$BattleCam.make_current()
	battle_id_lookup = load("res://battle_id.gd").new()
	set_up_senario([0, 0, 1], 0)


func set_up_senario(party, enemy_id):
	var loc=1
	for x in party:
		var character = load(battle_id_lookup.get_char_id(x))
		character = character.instance()
		character.position = get_node("party" + str(loc)).position
		add_child(character)
		character.set_owner(self)
		loc += 1
	
	loc = 1
	for x in battle_id_lookup.get_enemy_layout(enemy_id):
		var character = load(battle_id_lookup.get_char_id(x))
		character = character.instance()
		character.position = get_node("enemy" + str(loc)).position
		add_child(character)
		character.set_owner(self)
		loc += 1
	
	_regen_turn_order()
	for x in turnorder:
		x.connect("endturn", self, "_endturn")
		x.connect("died", self, "_clear_turn")
	
	$HUD.start_player_hp(turnorder[0].health_display_format())
	next_turn()



func next_turn():
	print(turnorder)
	if turnorder.empty():
		_regen_turn_order()
	if _checkend():
		return
	var nextchar = turnorder.pop_front()
	nextchar.pre_turn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _regen_turn_order():
	turnorder += get_tree().get_nodes_in_group("party")
	turnorder += get_tree().get_nodes_in_group("enemies")
	

func _endturn():
	print("end turn")
	next_turn()

func _clear_turn(to_be_removed):
	turnorder.erase(to_be_removed)
	_checkend()

func _checkend():
	var cache = get_tree().get_nodes_in_group("party") 
	for x in cache:
		if not x.active:
			cache.erase(x)
	
	if cache.empty():
		get_node("%HUD").game_over()
		return -1
	
	cache = get_tree().get_nodes_in_group("enemies")
	for x in cache:
		if not x.active:
			cache.erase(x)
	
	if cache.empty():
		get_node("%HUD").game_over("WIN")
		return 1
	
