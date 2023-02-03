extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		pass

func _on_icecream_hp_update(new_hp, max_hp, pos):
	print(new_hp)
	print(max_hp)
	var percent = min((float(new_hp) / float(max_hp) * 20), 19)
	var sections = round(percent)

	var newbar = $e_hpbar.duplicate(0)
	newbar.visible = true
	newbar.frame = int(sections)
	newbar.position = pos
	newbar.position.y += 50
	newbar.show()
	print(newbar.position)
	print(sections)

