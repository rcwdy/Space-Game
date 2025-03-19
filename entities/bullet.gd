extends Area2D

func _process(delta: float) -> void:
	position += 5 * Vector2(cos(rotation),sin(rotation))

func _on_on_screen_state_screen_exited() -> void:
	print("bullet gone")
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	print(area)
	print("hit")
	print("Baka")
	queue_free()
	
