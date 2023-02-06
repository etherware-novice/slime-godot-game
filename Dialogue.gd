extends CanvasLayer

signal dialog_finished_display
signal dialog_continue

var last_speaker

func _ready():
	load_dialogue("test")
	self.connect("dialog_continue", self, "tester")

func tester():
	print("dialog continued")

func load_dialogue(name, delay=false):
	last_speaker = null
	$AnimationPlayer.play("start_text")
	yield($AnimationPlayer, "animation_finished")
	var f = File.new()
	f.open("res://dialogue/" + name + ".txt", File.READ)
	if delay:
		$run_next.start()
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line().split(':', false, 1)
		print(line)
		if line.size() < 2:
			continue
		write_text(line[0], line[1])
		yield(self, "dialog_finished_display")
		yield(self, "dialog_continue")
	f.close()
	if delay:
		$run_next.stop()
	$AnimationPlayer.play_backwards("start_text")  # lmao

func _process(delta):
	if not $box/continue.visible:
		return
	if Input.is_action_just_pressed("ui_accept") && $run_next.is_stopped():
		emit_signal("dialog_continue")

func write_text(speaker, line):
	$box/speaker.visible = false
	$box/activeline.visible = false
	$box/speaker.text = speaker
	$box/activeline.text = line
	if last_speaker == speaker:
		$AnimationPlayer.play("reveal_text_same_speaker")
	else:
		$AnimationPlayer.play("reveal_text")
	last_speaker = speaker
	yield($AnimationPlayer, "animation_finished")
	emit_signal("dialog_finished_display")


func _on_run_next_timeout():
	emit_signal("dialog_continue")
