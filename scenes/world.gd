extends Node2D

func _process(delta: float) -> void:
	$"Health Placeholder".text = str($Player.health)
