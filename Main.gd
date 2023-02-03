extends Node2D

signal do_attack(target_pos)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$transition.start()
	$Camera2D.make_current()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_transition_timeout():
	var attack_pos = $icecream.position
	attack_pos.x -= 100
	emit_signal("do_attack", attack_pos)
	pass # Replace with function body.

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
		


func _on_beanie_attack():
	screen_shake()
