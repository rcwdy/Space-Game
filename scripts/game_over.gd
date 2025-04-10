extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("blur")

	if $HttpRequest:
		$HttpRequest.request_completed.connect(_on_request_completed)
		send_score("Test User", Globals.player_score)
	else:
		print("HttpRequest is null!")
 

func send_score(player_name, player_score):
	var url = "http://localhost:3000/submit-score"
	var headers = ["Content-Type: application/json"]
	var body = {
		"player": player_name,
		"score": player_score
	}
	var json_body = JSON.stringify(body)

	if $HttpRequest:
		print("Sending Score: %s, %d" % [player_name, player_score])
		$HttpRequest.request(url, headers, HTTPClient.METHOD_POST, json_body)
	else:
		print("HttpRequest is null")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 201:
		print("Score submitted")
	else:
		print("Failed to submit score:", response_code)

func _on_quit_button_pressed() -> void:
	Globals.save_game()
	get_tree().quit()

func _on_new_game_pressed() -> void:
	Globals.save_game()
	Globals.reset()
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_quit_to_menu_pressed() -> void:
	Globals.save_game()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
