extends Node2D

# Child of world, spawns boulders

var boulder = preload("res://entities/boulder.tscn")

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	#print($Spawntimer.time_left)
	if(get_child_count() >= 16):
		$Spawntimer.set_paused(true)
	else:
		$Spawntimer.set_paused(false)

func _on_spawntimer_timeout() -> void:
	createBoulder(0)
	
func createBoulder(instr : int):
	if(get_child_count() < 8):
		var boulder_make = boulder.instantiate()
		add_child(boulder_make,1)
		#print("Boulder Created @ " + str(boulder_make.position))

## TO-DO
func createBoulder2():
	if(get_child_count() < 16):
		var boulder_make = boulder.instantiate()
		var side = randi_range(0,3)
		match(side):
			0:
				# Spawning on top
				boulder_make.global_position = Vector2(randf_range(0,DisplayServer.window_get_size().x),0)
				boulder_make.direction = randf_range(180,360)
		add_child(boulder_make,1)	
