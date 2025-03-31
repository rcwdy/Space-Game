extends Control


func _on_volume_value_changed(value: float):
	AudioServer.set_bus_volume_db(0, value)


func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


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
			


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
