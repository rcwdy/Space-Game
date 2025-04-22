extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	get_tree().set_group("Pause Buttons","disabled",true)
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	#$PanelContainer/VBoxContainer/ResumeButton.set_disabled(false)
	get_tree().set_group("Pause Buttons","disabled",false)
	$AnimationPlayer.play("blur")
	

func testEsc():
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused == true:
		resume()


func _on_resume_button_pressed() -> void:
	resume()

func _on_restart_button_pressed() -> void:
	resume()
	Globals.reset()
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _process(_delta):
	testEsc()
	if get_tree().paused:
		if Input.is_key_pressed(KEY_Q):
			_on_return_button_pressed()
		elif Input.is_key_pressed(KEY_R):
			_on_restart_button_pressed()

func _on_return_button_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
