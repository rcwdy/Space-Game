extends Control

# onready waits till scene is ready
@onready var http_request = $HttpRequest
@onready var name_input = $PanelContainer/VBoxContainer/LineEdit
@onready var score_label = $PanelContainer/VBoxContainer/Score

# called when scene is loaded
func _ready():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("blur")
	score_label.text = "Score: " + str(Globals.player_score) # displays score 
	http_request.request_completed.connect(_on_request_completed)
	name_input.grab_focus()
	
# called when user presses enter after inputting name
func _on_line_edit_text_submitted(new_text: String) -> void:
	var name = new_text.strip_edges() # trims extra spaces at end or beginning
	if name == "":
		name = "Anonymous" # if no name is inputted, displays as anonymous
	send_score(name, Globals.player_score) #calls send score function

# called to send score to backend using HTTP request
func send_score(player_name: String, player_score: int) -> void:
	var url = "http://localhost:3000/submit-score" # API endpoint to save score
	var headers = ["Content-Type: application/json"] # set request content type
	var body = {
		"player": player_name,
		"score": player_score
	}
	var json_body = JSON.stringify(body) # convert data to json string

	http_request.request(url, headers, HTTPClient.METHOD_POST, json_body) # the HTTP request

# called when HTTP request finishes
func _on_request_completed(result, response_code, headers, body):
	if response_code == 201: # if score is submitted successfully, it changes to game over screen
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
