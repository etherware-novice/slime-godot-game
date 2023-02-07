extends AnimatedSprite


func setup(percent, pos):
	frame = int(percent)
	position = pos + Vector2(0, 50)
	
	return self

func calculate_hp_bar(hp, maxhp, pos):
	var percent = min((float(hp) / float(maxhp) * 20), 19)
	var sections = round(percent)
	
	return setup(sections, pos)
