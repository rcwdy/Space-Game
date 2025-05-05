extends Control

# Returns to the main menu
func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

# Goes to the next tutorial screen
func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial_2.tscn")
