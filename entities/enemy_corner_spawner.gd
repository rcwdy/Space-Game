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

enum{
	NORMAL = 10, SPLIT = 11
}

func _ready() ->void:
	var parent = get_parent()
	if(("time" in parent && parent.has_node("Player"))):
		can_produce = true

func _process(delta: float) -> void:
	pass
	#print("Time until next spawn: " + str($SpawnTimer.time_left))
	#print("Wait Time: " + str($SpawnTimer.wait_time))

func _on_spawn_timer_timeout() -> void:
	if(can_produce):
		$SpawnTimer.set_wait_time(1 * (pow(1.1,1 - Globals.level)))
		direction = randi_range(0,$Locations.get_child_count() - 1)
		#direction = randi_range(0,3)
		print(direction)
		spawn(direction,false)

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

func spawn(corner: int, new: bool) -> void:
	
	if(can_produce && $Enemies.get_child_count() < int(Spawns.json_data["level"+str(Globals.level)].get("max_enemies"))):
		var boulder = pickEnemy().instantiate()
		#var boulder = boulder_make.instantiate()
		var side = randi_range(0,1)
		print("Side" + str(side))
		var coords = newCoords(corner)
		boulder.global_position.x = coords.x
		boulder.global_position.y = coords.y
		boulder.direction = coords.z
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
		return coords
		
func pickEnemy() -> Resource:
	var lvl = Globals.level
	var num = randi_range(1,100)
	match(lvl):
		1, 2:
			return boulder_make
		3:
			if(num <= 75):
				return boulder_make
			else:
				return split_make
		4:
			if(num <= 65):
				return boulder_make
			else:
				return split_make
		5, 6:
			if(num <= 60):
				return boulder_make
			elif(num <= 90):
				return split_make
			else:
				return marty_make
		7:
			if(num <= 48):
				return boulder_make
			elif(num <= 82):
				return split_make
			elif(num <= 98):
				return marty_make
			else:
				return gold_make
		_:
			return boulder_make
