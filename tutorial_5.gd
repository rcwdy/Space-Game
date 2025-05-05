extends Control

# Goes to the previous tutorial screen
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial_4.tscn")

# Goes to the next tutorial screen
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial_6.tscn")
