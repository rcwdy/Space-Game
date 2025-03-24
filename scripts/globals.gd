extends Node

var player_health
var player_score
var high_score
var enemy_kills

var screenRes = DisplayServer.window_get_size()

var no_data = true
# When no data is detected 
func _ready() -> void:
	if(no_data):
		high_score = 5000
		reset()

# When player gets hit they lose health
func loseHealth(damage_dealt: int) -> void:
	player_health -= damage_dealt

func gainPoints(points_earned: int) -> void:
	player_score += points_earned
	if(player_score > high_score):
		high_score = player_score
	print(player_score)
func reset() -> void:
	player_health = 10
	player_score = 0
	enemy_kills = 0
