extends Control

# When player dies: saves high score 
func _ready() -> void:
	Globals.save_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_quit_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
