extends Node2D
var direction = 8
var boulder_make = preload("res://entities/boulder.tscn")
var can_produce = false

enum{
	NORTHWEST, NORTH, NORTHEAST,WEST,EAST,SOUTHWEST,SOUTH,SOUTHEAST
}

func _ready() ->void:
	var parent = get_parent()
	if(("time" in parent && parent.has_node("Player"))):
		can_produce = true
	
	print($Locations.get_child(4))
	print(rad_to_deg($Center.get_angle_to($Locations/Northwest.global_position)))
	print(rad_to_deg($Center.get_angle_to($Locations/North.global_position)))
	print(rad_to_deg($Center.get_angle_to($Locations/Northeast.global_position)))
	print(rad_to_deg($Center.get_angle_to($Locations/South.global_position)))

func waveIncrease()->void:
	Globals.waveIncrease()

func _on_spawn_timer_timeout() -> void:
	if(can_produce):
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
	
	if(can_produce && $Enemies.get_child_count() < 16):
		var boulder = boulder_make.instantiate()
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
