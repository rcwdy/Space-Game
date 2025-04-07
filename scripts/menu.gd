extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()
#Add scene change 
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit() 

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _process(_delta: float) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_leaderboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")
