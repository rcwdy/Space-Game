extends Node2D
var time = 0
var alive = true

func CheckAlive():
	if Globals.player_health < 1:
		get_tree().change_scene_to_file("res://scenes/score_submission.tscn")

func _process(_delta: float) -> void:
	$"Health Placeholder".text = "Health:" +str(Globals.player_health)
	time += _delta
	#if(int(time) % 60 == 0):
	#	Globals.waveIncrease()
	$"Timer Placeholder".text = str(int(time))
	$"Score Placeholder".text = "Score:" + str(Globals.player_score)
	
	if(Input.is_action_just_pressed("Increase 60 seconds")):
		time += 60
	CheckAlive()
