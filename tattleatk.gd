extends specatk


func get_name():
	return "Research"

func do_attack(target):
	var id = target.get_id()
	var main = target.get_parent()  # very hacky but oops
	
	var HUD = main.get_node("Dialogue")
	
	HUD.load_dialogue("tattle/" + str(id))
	yield(HUD, "dialog_close")
