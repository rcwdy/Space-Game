extends Control

func _ready():
	# Plays the music for the game
	BGM.play_song(load("res://audio/spaceship-arcade-shooter-game-background-soundtrack-318508.mp3"))
	$VBoxContainer/StartButton.grab_focus()
	$"High-Score".text = "High Score:\n" + str(Globals.high_score)
# Starts the game
func _on_start_button_pressed() -> void:
	Globals.reset()
	get_tree().change_scene_to_file("res://scenes/world.tscn")

# Closes the game
func _on_quit_button_pressed() -> void:
	get_tree().quit() 

# Opens the settings menu
func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _process(_delta: float) -> void:
	pass

# Goes to the leaderboard menu
func _on_leaderboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")

# Goes to the tutorial screen
func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial_1.tscn")
