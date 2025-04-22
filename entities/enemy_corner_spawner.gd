extends Node2D
var direction = 8

var boulder_make = preload("res://entities/boulder.tscn")
var split_make = preload("res://entities/split.tscn")
var marty_make = preload("res://entities/martyrdom.tscn")
var gold_make = preload("res://entities/golden.tscn")
var homing_make = preload("res://entities/homing.tscn")
var bfg_make = preload("res://entities/bfg.tscn")

var can_produce = false

enum{
	NORTHWEST, NORTH, NORTHEAST,WEST,EAST,SOUTHWEST,SOUTH,SOUTHEAST
}

# On startup, checks if parent is valid
func _ready() ->void:
	var parent = get_parent()
	if(("time" in parent && parent.has_node("Player"))):
		can_produce = true

func _process(_delta: float) -> void:
	# If BFG is on-screen stop spawning of enemies
	if has_node("Enemies/BFG"):
		can_produce = false
	else:
		can_produce = true

func _on_spawn_timer_timeout() -> void:
	if(can_produce):
		$SpawnTimer.set_wait_time(1.25 * (pow(1.1,1 - Globals.level)))
		direction = randi_range(0,$Locations.get_child_count() - 1)
		#direction = randi_range(0,3)
		print(direction)
		spawn(direction)

func cardinal(value: int) -> String:
	match(value):
		NORTHWEST:
			return 'NORTHWEST'
		NORTH:
			return 'NORTH'
		NORTHEAST:
			return 'NORTHEAST'
		WEST:
			return 'WEST'
		EAST:
			return 'EAST'
		SOUTHWEST:
			return 'SOUTHWEST'
		SOUTH:
			return 'SOUTH'
		SOUTHEAST:
			return 'SOUTHEAST'
	return 'ERROR'

func spawn(corner: int, override: bool = false) -> void:
	if(can_produce):
		if(override || $Enemies.get_child_count() < Globals.max_enemies):
			var boulder = pickEnemy().instantiate()
			var side = randi_range(0,1)
			print("Side" + str(side))
			var coords = newCoords(corner)
			boulder.global_position.x = coords.x
			boulder.global_position.y = coords.y
			boulder.direction = coords.z
			
			# Base Speed * Speed Multiplier By Level + 10-Level Loop Speed Increase
			
			boulder.speed = randf_range(0.5,0.7) * (Spawns.data["level"+str(Globals.level % 10 + 1)].get("enemy_speed")) + (0.6 * ((Globals.level - 1) / 10))
			boulder.add_to_group("Enemy")
		
			$Enemies.add_child(boulder,true)

func newCoords(corner: int) -> Vector3:
		var coords: Vector3
		var side = randi_range(0,1)
		
		match(corner):
			NORTHWEST:
				if(side):
					coords.x = randf_range(0,Globals.screenRes.x * 0.25)
					coords.y = 0
				else:
					coords.x = 0
					coords.y = randf_range(0,Globals.screenRes.y * 0.25)
			NORTH:
					coords.x = randf_range(Globals.screenRes.x * 0.25,Globals.screenRes.x * 0.75)
					coords.y = 0
			NORTHEAST:
				if(side):
					coords.x = randf_range(Globals.screenRes.x * 0.75, Globals.screenRes.x)
					coords.y = 0
				else:
					coords.x = Globals.screenRes.x
					coords.y = randf_range(0,Globals.screenRes.y * 0.25)
			WEST:
					coords.x = 0
					coords.y = randf_range(Globals.screenRes.y * 0.25,Globals.screenRes.y * 0.75)
			EAST:
					coords.x = Globals.screenRes.x
					coords.y = randf_range(Globals.screenRes.y * 0.25,Globals.screenRes.y * 0.75)
			SOUTHWEST:
				if(side):
					coords.x = randf_range(0,Globals.screenRes.x * 0.25)
					coords.y = Globals.screenRes.y
				else:
					coords.x = 0
					coords.y = randf_range(Globals.screenRes.y * 0.75,Globals.screenRes.y)
			SOUTH:
					coords.x = randf_range(Globals.screenRes.x * 0.25,Globals.screenRes.x * 0.75)
					coords.y = Globals.screenRes.y
			SOUTHEAST:
				if(side):
					coords.x = randf_range(Globals.screenRes.x * 0.75, Globals.screenRes.x)
					coords.y = Globals.screenRes.y
				else:
					coords.x = Globals.screenRes.x
					coords.y = randf_range(0.75 * Globals.screenRes.y,Globals.screenRes.y)
		coords.z = rad_to_deg(($Locations.get_child(corner)).get_angle_to($Center.position)) + randi_range(-30,30)
		print("Corner: " + str(cardinal(corner)) + str(coords))
		#coords.x -= (Vector2(coords.x,coords.y).direction_to($Center.global_position) * 100).x	
		#coords.y -= (Vector2(coords.x,coords.y).direction_to($Center.global_position) * 100).y	
		return coords

func pickEnemy() -> Resource:
	var lvl = Globals.level
	var num = randi_range(0,99)
	var table = Spawns.data["level" + str((lvl - 1) % 10 + 1)]["enemies"]
	for i in table:
		var requirement = table[i]
		if(num < requirement):
			return enemyStringToResource(i)
	return boulder_make

func enemyStringToResource(name: String) -> Resource:
	if(name == "boulder"):
		return boulder_make
	elif(name == "split"):
		return split_make
	elif(name == "martyrdom"):
		return marty_make
	elif(name == "golden"):
		return gold_make
	elif(name == "homing"):
		return homing_make
	elif(name == "bfg"):
		get_tree().call_group("Enemy","queue_free")
		return bfg_make
	else:
		return boulder_make

func scripted_kill():
	print(self, "was killed by some Force")
	queue_free()
