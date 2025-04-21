extends Node2D
var time = 0
var alive = true

func CheckAlive():
	if Globals.player_health < 1:
		get_tree().change_scene_to_file("res://scenes/score_submission.tscn")

func _ready():
	Globals.reset()
	updateBar()

func _process(_delta: float) -> void:
	$"Health".text = "Health:" +str(Globals.player_health)
	time += _delta
	$"Playtime".text = Time.get_time_string_from_system()
	$"Score".text = "Score:" + str(Globals.player_score)
	$EXPBar.value = Globals.current_exp
	CheckAlive()
	
	if $EXPBar.value >= $EXPBar.max_value:
		updateBar()
	


func updateBar():
	$EXPBar.max_value = Globals.level_req
	$EXPBar.min_value = $EXPBar.value
	$EXPBar/Level.set_text("Level: " + str(Globals.level))
	$EXPBar/Goal.set_text(str(int($EXPBar.max_value)))
