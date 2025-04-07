extends Node

# UPGRADES
enum{
	BULLET_SPEED_MULTIPLIER = 0, BULLET_SIZE_MULTIPLIER = 1, DOUBLE_BULLET = 15, AIMED_BULLET = 16
}

var debug_upgrade_num = 0

var player_health
var player_score
var high_score
var enemy_kills

var current_exp
var level
var level_req = 10

var screenRes = DisplayServer.window_get_size()

var playerShootSpeed = 0.25

const playerBulletSpeed = 6 # Influences player bullet speed
var playerBulletSpeedMulti = 1.0 

var playerBulletCount = 0
var playerBulletHoming = false
var playerBulletSize = 1.0
var playerBulletDamage = 1
var playerDashAttack = 0

var playerBulletMouse = false
var playerBulletWave = false
var playerBulletSlow = false
var autofire = false

var enemySpeed = 1.0
var enemySpawnSpeed = 1.0
var enemySpawnMax = 8

var no_data = true

func save_game():
	var save = FileAccess.open("user://local_high_score.spc", FileAccess.WRITE)
	save.store_string(str(high_score))
	save.close()

func load_game():
	var save = FileAccess.open("user://local_high_score.spc", FileAccess.READ)
	if(save != null):
		high_score = save.get_line().to_int()
		no_data = false
		return

# When no data is detected 
func reset() -> void:
	player_health = 10
	player_score = 0
	enemy_kills = 0
	current_exp = 0
	level = 1
	level_req = 10
	
	playerBulletSpeedMulti = 1.0 
	playerBulletSize = 1.0
	playerBulletDamage = 1
	playerBulletCount = 0
	playerBulletHoming = 0
	playerDashAttack = 0
	playerShootSpeed = 0.25
	autofire = false
	
func _ready() -> void:
	#Testing
	load_game()
	print(Vector2(1,1) < Vector2(0,0))
	print(Vector2(1,1) > Vector2(0,0))
	print(Vector2(1,2.25) == Vector2(1.5,1.5))
	reset()
	if(no_data):
		high_score = 100

func _process(delta: float) -> void:
	debugUpgrade()


# When player gets hit they lose health
func loseHealth(damage_dealt: int) -> void:
	player_health -= damage_dealt

func gainPoints(points_earned: int) -> void:
	player_score += points_earned
	if(player_score > high_score):
		high_score = player_score
	print("Current Score: " + str(player_score))
	print("High Score: " + str(high_score))

func gainExp(exp: int) -> void:
	current_exp += exp
	if(current_exp >= level_req):
		level += 1
		level_req = (int)(level_req * 1.5)

func debugExp() -> void:
	gainExp(level_req)

func bulletSpeedIncrease() -> void:
	if(playerBulletSpeedMulti < 3):
		playerBulletSpeedMulti += 0.1  
		
func bulletSizeIncrease() -> void:
	if(playerBulletSize < 2.99):
		playerBulletSize += 0.4

func bulletDamageIncrease() -> void:
	if(playerBulletDamage < 10):
		playerBulletDamage += 1

func bulletCountIncrease() -> void:
	if(playerBulletCount < 10):
		playerBulletCount += 2

func shootSpeedIncrease() -> void:
	if(playerShootSpeed > 0.05):
		playerShootSpeed -= 0.02

func bulletHomingIncrease() -> void:
	playerBulletHoming = !playerBulletHoming

func toggleDashAttack() -> void:
	playerDashAttack = !playerDashAttack

func toggleAutoFire() -> void:
	autofire = !autofire

func levelIncrease() -> void:
	enemySpeed += 0.1
	enemySpawnSpeed += 0.1
	enemySpawnMax += 1

func debugUpgrade():
	if(Input.is_action_just_pressed("Debug Increase Bullet Speed")):
		bulletSpeedIncrease()
		print("Bullet Speed Multiplier " + str(playerBulletSpeedMulti))
	if(Input.is_action_just_pressed("Debug Increase Bullet Size")):
		bulletSizeIncrease()
		print("Bullet Size " + str(playerBulletSize))
	if(Input.is_action_just_pressed("Debug Increase Bullet Damage")):
		bulletDamageIncrease()
		print("Bullet Damage " + str(playerBulletDamage))
	if(Input.is_action_just_pressed("Debug Increase Bullet Count")):
		bulletCountIncrease()
		print("Bullet Count " + str(playerBulletCount))	
	if(Input.is_action_just_pressed("Debug Increase Bullet Homing ")):
		bulletHomingIncrease()
		print("Bullet Homing: " + str(playerBulletHoming))
	if(Input.is_action_just_pressed("Debug Player Dash Attack ")):
		toggleDashAttack()
		print("Dash Attack: " + str(playerDashAttack))
	if(Input.is_action_just_pressed("Debug Auto Fire")):
		toggleAutoFire()
		print("Autofire: " + str(autofire))
	if(Input.is_action_just_pressed("Debug Increase Shooting Speed")):
		shootSpeedIncrease()
		print("Shooting Speed: " + str(playerShootSpeed))
	if(Input.is_action_just_pressed("Increase 60 seconds")):
		debugExp()
		print("Current Exp: " + str(current_exp))
