extends Control

func _ready():
	BGM.play_song(load("res://audio/spaceship-arcade-shooter-game-background-soundtrack-318508.mp3"))
	$VBoxContainer/StartButton.grab_focus()
	$"High-Score".text = "High Score:\n" + str(Globals.high_score)
#Add scene change 
func _on_start_button_pressed() -> void:
	Globals.reset()
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit() 

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _process(_delta: float) -> void:
	pass

func _on_leaderboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")
