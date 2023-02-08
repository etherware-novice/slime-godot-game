extends character

class_name enemy

var hpbar = preload("res://hpbar.tscn")
var cached_hpbar

func _ready():
	add_to_group("enemies")
	print("added to enemies")
	._ready()

func _pre_turn():
	clear_hp_bar()
	._pre_turn()

func _sub_hp(damage):
	._sub_hp(damage)
	display_hp_bar(5)

func on_death():
	.on_death()
	yield($AnimatedSprite, "animation_finished")
	remove_from_group("enemies")
	active = false
	$AnimatedSprite.animation = "deathhold"
	yield(get_tree().create_timer(5.0), "timeout")
	queue_free()
	


func display_hp_bar(timeout = null):
	if cached_hpbar:
		clear_hp_bar()
	cached_hpbar = hpbar.instance()
	add_child(cached_hpbar)
	#get_global_transform_with_canvas().get_origin()
	cached_hpbar.calculate_hp_bar(hp, maxhp, Vector2(0,0))
	if timeout:
		var temp = cached_hpbar
		yield(get_tree().create_timer(timeout), "timeout")
		clear_hp_bar(temp)
	else:
		return cached_hpbar

# so external nodes can still clear it
func clear_hp_bar(prev_bar = null):
	if is_instance_valid(cached_hpbar):
		if prev_bar:
			if prev_bar != cached_hpbar:
				return
		cached_hpbar.queue_free()
