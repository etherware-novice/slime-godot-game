extends specatk


func get_name():
	return "Research"

func do_attack(user, target):
	var id = target.get_id()
	var main = target.get_parent()  # very hacky but oops
	var HUD = main.get_node("Dialogue")
	var sprite = user.get_node("AnimatedSprite")
	
	sprite.animation = "read_start"
	yield(sprite, "animation_finished")
	
	sprite.animation = "read_loop"
	HUD.load_dialogue("tattle/" + str(id))
	yield(HUD, "dialog_close")

	sprite.play("read_start", true)  # backwards
	yield(sprite, "animation_finished")
	sprite.play("idle", false)  # fixes backwrads
