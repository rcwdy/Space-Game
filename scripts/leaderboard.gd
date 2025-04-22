extends Control

@onready var http_request = $HttpRequest
@onready var score_list = $PanelContainer/VBoxContainer

func _ready():
	http_request.request_completed.connect(_on_request_completed)
	fetch_scores()

func fetch_scores():
	var url = "http://localhost:3000/high-scores"
	var headers = []
	http_request.request(url, headers, HTTPClient.METHOD_GET)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		if typeof(json) == TYPE_ARRAY:
			display_scores(json)
	else:
		print("Failed to load leaderboard:", response_code)

func display_scores(scores):
	for i in range(min(scores.size(), score_list.get_child_count())):
		var entry = scores[i]
		var label = score_list.get_child(i)
		label.text = "%d. %s - %d" % [i + 1, entry.player, entry.score]

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
