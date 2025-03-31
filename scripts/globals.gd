extends Node

# UPGRADES
enum{
	BULLET_SPEED_MULTIPLIER = 0, BULLET_SIZE_MULTIPLIER = 1, DOUBLE_BULLET = 15, AIMED_BULLET = 16
}
var upgrades = [0, 0]
var debug_upgrade_num = 0

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

func _process(delta: float) -> void:
	debugUpgrade()

func debugUpgrade():
	# Changes value of selected upgrade
	if(Input.is_action_just_pressed("Debug 0")):
		print("Old Value: " + str(upgrades[debug_upgrade_num]))
		upgrades[debug_upgrade_num] += 1
		print("New Value: " + str(upgrades[debug_upgrade_num]))
	if(Input.is_action_just_pressed("Debug 1")):
		if(debug_upgrade_num < upgrades.size() - 1):
			debug_upgrade_num += 1
		else:
			debug_upgrade_num = 0
