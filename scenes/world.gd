extends Node2D

func _process(_delta: float) -> void:
	$"Health Placeholder".text = "Health:" +str(Globals.player_health)
	$"Score Placeholder".text = "Score:" + str(Globals.player_score)
