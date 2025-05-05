extends Node2D
var time = 0
var alive = true
var level = 1

func CheckAlive():
	if Globals.player_health < 1:
		get_tree().change_scene_to_file("res://scenes/score_submission.tscn")

# Updates User Interface every frame
func _process(_delta: float) -> void:
	$"Health".text = "Health:" +str(Globals.player_health)
	time += _delta
	$"Playtime".text = str(int(time))
	$"Score".text = "Score:" + str(Globals.player_score)
	$EXPBar.value = Globals.current_exp
	CheckAlive()
	
	if $EXPBar.value >= $EXPBar.max_value:
		updateBar()
	

# Updates EXP Bar if Level Up Occurs
func updateBar():
	$EXPBar.max_value = Globals.level_req
	$EXPBar.min_value = $EXPBar.value
	$EXPBar/Level.set_text("Level: " + str(Globals.level))
	$EXPBar/Goal.set_text(str(int($EXPBar.max_value)))
	if level < Globals.level:
		upgrade_menu.open(upgrades, upgrade_counts)
	level = Globals.level

@onready var upgrade_menu := preload("res://scenes/upgrade_menu.tscn").instantiate()
@onready var canvas_layer := CanvasLayer.new()

var upgrades: Array[Dictionary] = [
	{"id": "bullet_speed", "icon": preload("res://images/BulletSpeed.png"), "max_uses": 20},
	{"id": "bigger_projectile", "icon": preload("res://images/BiggerProjectile.png"), "max_uses": 5},
	{"id": "spread_shot", "icon": preload("res://images/SpreadShot.png"), "max_uses": 5},
	{"id": "stronger_bullets", "icon": preload("res://images/StrongerBullets.png"), "max_uses": 8},
	{"id": "rocket_launcher", "icon": preload("res://images/RocketLauncher.png"), "max_uses": 1},
]

var upgrade_counts := {} 

func _ready():
	Globals.reset()
	updateBar()
	canvas_layer.add_child(upgrade_menu)
	add_child(canvas_layer)

	upgrade_menu.upgrade_selected.connect(_on_upgrade_chosen)


func _on_upgrade_chosen(upgrade_id: String):
	print("Chosen upgrade:", upgrade_id)
	if upgrade_id == "bullet_speed":
		Globals.bulletSpeedIncrease()
		print(Globals.playerBulletSpeedMulti)
	elif upgrade_id == "bigger_projectile":
		Globals.bulletSizeIncrease()
		print(Globals.playerBulletSize)
	elif upgrade_id == "spread_shot":
		Globals.bulletCountIncrease()
		print(Globals.playerBulletCount)
	elif upgrade_id == "stronger_bullets":
		Globals.bulletDamageIncrease()
		print(Globals.playerBulletLevel)
	else:
		print("Upgrade not Implemented!")
