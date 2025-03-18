extends Area2D

func _process(delta: float) -> void:
	global_position.x += 5

func _on_on_screen_state_screen_exited() -> void:
	print("bullet gone")
	queue_free()
