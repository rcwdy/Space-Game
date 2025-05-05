extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/Volume.set_value(AudioServer.get_bus_volume_linear(0))

# Adjusts the volume of the music
func _on_volume_value_changed(value: float):
	AudioServer.set_bus_volume_linear(0,value)

# Mutes the music of the game
func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)

# Resolutions options for the game
func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1280,960))
		1:
			DisplayServer.window_set_size(Vector2i(1024,768))
		2:
			DisplayServer.window_set_size(Vector2i(800,600))
		3:
			DisplayServer.window_set_size(Vector2i(640,480))
			

# Returns to the main menu
func _on_return_button_pressed() -> void:
	#Globals.volume = $MarginContainer/VBoxContainer/Volume.value
	#Globals.mute = $MarginContainer/VBoxContainer/Mute.toggle_mode
	#Globals.resolution = $MarginContainer/VBoxContainer/Mute.selected
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
