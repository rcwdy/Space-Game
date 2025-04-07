extends Node2D
var time = 0
var alive = true

func CheckAlive():
	if Globals.player_health < 1:
		Globals.save_game()
		get_tree().change_scene_to_file("res://game_over.tscn")

func _process(_delta: float) -> void:
	$"Health Placeholder".text = "Health:" +str(Globals.player_health)
	time += _delta
	$"Timer Placeholder".text = str(int(time))
	$"Score Placeholder".text = "Score:" + str(Globals.player_score)
	
	if(Input.is_action_just_pressed("Increase 60 seconds")):
		time += 60
	CheckAlive()
	
	$EXPBar.max_value = Globals.level_req
	$EXPBar.value = Globals.current_exp
