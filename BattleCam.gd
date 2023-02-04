extends Camera2D


func screen_shake():
	var orig = position
	var random = RandomNumberGenerator.new()
	random.randomize()
	$shake.start()
	
	var i = 0
	while i < 5:
		position += Vector2(random.randi_range(-7, 7), random.randi_range(-7, 7))
		yield($shake, "timeout")
		i += 1
	
	$shake.stop()
	position = orig
