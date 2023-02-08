extends enemy

var fuse = 1

func _ready():
	targetable = false

func health_display_format():
	return "BOMB"

func do_attack():
	yield(get_tree().create_timer(2), "timeout")
	fuse -= 1
	if fuse < 0:
		var mid = get_parent().get_node("partymid").position
		$Tween.interpolate_property(self, "position",
			null, mid, 1,
			Tween.TRANS_QUART, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
		
		$AnimatedSprite.animation = "explode"
		for x in get_tree().get_nodes_in_group("party"):
			x._sub_hp(9999)
		yield($AnimatedSprite, "animation_finished")
		emit_signal("endturn")
		queue_free()
	else:
		get_node("%HUD").new_damage_num(fuse, get_global_transform_with_canvas().get_origin())
	emit_signal("endturn")
