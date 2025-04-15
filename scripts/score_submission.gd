extends Control

@onready var http_request = $HttpRequest
@onready var name_input = $PanelContainer/VBoxContainer/LineEdit
@onready var score_label = $PanelContainer/VBoxContainer/Score

func _ready():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("blur")
	score_label.text = "Score: " + str(Globals.player_score)
	http_request.request_completed.connect(_on_request_completed)
	name_input.grab_focus()
	
func _on_line_edit_text_submitted(new_text: String) -> void:
	var name = new_text.strip_edges()
	if name == "":
		name = "Anonymous"
	send_score(name, Globals.player_score)

func send_score(player_name: String, player_score: int) -> void:
	var url = "http://localhost:3000/submit-score"
	var headers = ["Content-Type: application/json"]
	var body = {
		"player": player_name,
		"score": player_score
	}
	var json_body = JSON.stringify(body)

	http_request.request(url, headers, HTTPClient.METHOD_POST, json_body)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 201:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
