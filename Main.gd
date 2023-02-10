extends Node2D

signal do_attack(target_pos)


var turnorder = []
var turncount = 0

var enemy_senario

onready var battle_id_lookup = load("res://battle_id.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$BattleCam.make_current()
	set_up_senario([0, 1], [1], 3)


func set_up_senario(party, atks, enemy_id):
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
	
	enemy_senario = enemy_id
	_regen_turn_order()
	for x in turnorder:
		x.connect("endturn", self, "_endturn")
		x.connect("died", self, "_clear_turn")
	
	$HUD.start_player_hp(turnorder[0].health_display_format(), atks)
	next_turn()



func next_turn():
	print(turnorder)
	if turnorder.empty():
		_regen_turn_order()
	var layout_state = battle_id_lookup.get_layout_unique_data(self)
	if layout_state is GDScriptFunctionState:  # yield workaround
		yield(layout_state, "completed")
	print("nextturn")
	if _checkend():
		return
	var nextchar = turnorder.pop_front()
	if turncount == 2:
		pass
	nextchar.pre_turn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _regen_turn_order():
	turncount += 1
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
	
