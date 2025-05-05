extends Control

# Ressets the pause animation
func _ready():
	$AnimationPlayer.play("RESET")

# Resumes the game
func resume():
	get_tree().paused = false
	get_tree().set_group("Pause Buttons","disabled",true)
	$AnimationPlayer.play_backwards("blur")

# Pauses the game
func pause():
	get_tree().paused = true
	#$PanelContainer/VBoxContainer/ResumeButton.set_disabled(false)
	get_tree().set_group("Pause Buttons","disabled",false)
	$AnimationPlayer.play("blur")

# Pauses the game if the esc key is pressed
func testEsc():
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused == true:
		resume()

# Unpauses the game when button is clicked
func _on_resume_button_pressed() -> void:
	resume()

# Restarts the current run when button is clicked
func _on_restart_button_pressed() -> void:
	resume()
	Globals.reset()
	get_tree().reload_current_scene()

# Closes the game when button is clicked
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _process(_delta):
	# Checks if the esc key has been pressed
	testEsc()
	if get_tree().paused:
		if Input.is_key_pressed(KEY_Q):
			_on_return_button_pressed()
		elif Input.is_key_pressed(KEY_R):
			_on_restart_button_pressed()

# Sends the player back to the main menu when button is clicked
func _on_return_button_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
