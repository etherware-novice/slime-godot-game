extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#update_number(15, Vector2(100, 100))
	#update_number(1500, Vector2(400, 200))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_number(number, target):
	print("update_num")
	position = target * 0.5  # w h y
	position += Vector2(30, 0)
	print(target)

	var numoffset = position
	for x in str(number):
		var nsprite = $AnimatedSprite.duplicate()
		nsprite.visible = true
		nsprite.frame = int(x)
		nsprite.position = numoffset
		numoffset.x += 30
		add_child(nsprite)
		add_to_group("num")
	print(target)
	
	$Timer.start()
	var peak = position
	peak += Vector2(30, -10)
	$Tween.interpolate_property(self, "position",
		null, peak, 0.4,
		Tween.TRANS_QUART, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	
	peak += Vector2(10, 10)
	$Tween.interpolate_property(self, "position",
		null, peak, 0.4,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	
	$Tween.interpolate_property(self, "scale",
		null, Vector2(1, -301), 2,
		Tween.TRANS_QUART, Tween.EASE_IN)
	#$Tween.start()
	


func _on_Timer_timeout():
	get_tree().call_group("num", "queue_free")

