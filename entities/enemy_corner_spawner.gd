extends Node2D
var direction = 8

var boulder_make = preload("res://entities/boulder.tscn")
var split_make = preload("res://entities/split.tscn")
var marty_make = preload("res://entities/martyrdom.tscn")
var gold_make = preload("res://entities/golden.tscn")

var enemyArray = [boulder_make,split_make,marty_make]

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

func spawn(value: int) -> void:
	
	if(can_produce && $Enemies.get_child_count() < 8 + Globals.level - 1):
		var boulder = pickEnemy().instantiate()
		#var boulder = boulder_make.instantiate()
		var side = randi_range(0,1)
		print("Side" + str(side))
		match(value):
			NORTHWEST:
				if(side):
					boulder.position.x = randf_range(0,Globals.screenRes.x / 4)
					boulder.position.y = 0
				else:
					boulder.position.x = 0
					boulder.position.y = randf_range(0,Globals.screenRes.y / 4)
				boulder.direction = randi_range(5,85)
			NORTH:
					boulder.position.x = randf_range(Globals.screenRes.x / 4,3 * Globals.screenRes.x / 4)
					boulder.position.y = 0
					boulder.direction = randi_range(10,170)
			NORTHEAST:
				if(side):
					boulder.position.x = randf_range(3 * Globals.screenRes.x / 4,Globals.screenRes.x)
					boulder.position.y = 0
				else:
					boulder.position.x = 0
					boulder.position.y = randf_range(0,Globals.screenRes.y / 4)
				boulder.direction = randi_range(95,175)
			WEST:
					boulder.position.x = 0
					boulder.position.y = randf_range(Globals.screenRes.y / 4,3 * Globals.screenRes.y / 4)
					boulder.direction = randi_range(-85,85)
			EAST:
					boulder.position.x = Globals.screenRes.x
					boulder.position.y = randf_range(Globals.screenRes.y / 4,3 * Globals.screenRes.y / 4)
					boulder.direction = randi_range(90,270)
			SOUTHWEST:
				if(side):
					boulder.position.x = randf_range(0,Globals.screenRes.x / 4)
					boulder.position.y = Globals.screenRes.y
				else:
					boulder.position.x = 0
					boulder.position.y = randf_range(3 * Globals.screenRes.y / 4,Globals.screenRes.y)
				boulder.direction = randi_range(-5,-85)
			SOUTH:
					boulder.position.x = randf_range(Globals.screenRes.x / 4,3 * Globals.screenRes.x / 4)
					boulder.position.y = Globals.screenRes.y
					boulder.direction = randi_range(-10,-170)
			SOUTHEAST:
				if(side):
					boulder.position.x = randf_range(3 * Globals.screenRes.x / 4, Globals.screenRes.x)
					boulder.position.y = Globals.screenRes.y
				else:
					boulder.position.x = Globals.screenRes.x
					boulder.position.y = randf_range(0.75 * Globals.screenRes.y,Globals.screenRes.y)
				boulder.direction = randi_range(185,265)
		print(boulder.direction)
		$Enemies.add_child(boulder,true)

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
