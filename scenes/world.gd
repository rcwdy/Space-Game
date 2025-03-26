extends Node2D
var time = 0
var alive = true

func _process(_delta: float) -> void:
	$"Health Placeholder".text = "Health:" +str(Globals.player_health)
	time += _delta
	$"Timer Placeholder".text = str(int(time))
	$"Score Placeholder".text = "Score:" + str(Globals.player_score)
