extends Control

# onready waits till scene is ready
@onready var http_request = $HttpRequest
@onready var score_list = $PanelContainer/VBoxContainer

# called when scene is loaded
func _ready():
	http_request.request_completed.connect(_on_request_completed)
	fetch_scores() # used to get scores from database

# called to get scores from database
func fetch_scores():
	var url = "http://localhost:3000/high-scores" # API endpoint to get the 10 highest scores
	var headers = []
	http_request.request(url, headers, HTTPClient.METHOD_GET)

# handles response from the request
func _on_request_completed(result, response_code, headers, body):
	if response_code == 200: # if successful, turn json response into array
		var json = JSON.parse_string(body.get_string_from_utf8())
		if typeof(json) == TYPE_ARRAY:
			display_scores(json) # place scores into leaderboard
	else:
		print("Failed to load leaderboard:", response_code) # error message if failed request

# used to update labels in the leaderboard menu
func display_scores(scores):
	for i in range(min(scores.size(), score_list.get_child_count())):
		var entry = scores[i] # gets entries from database using a loop
		var label = score_list.get_child(i) # gets the labels to be changed
		label.text = "%d. %s - %d" % [i + 1, entry.player, entry.score] # formats display

# used when return button is pressed
func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn") # changes scene to menu screen
