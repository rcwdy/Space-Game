extends Node2D

var boulder = preload("res://entities/boulder.tscn")

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	#print($Spawntimer.time_left)
	if(get_child_count() >= 16):
		$Spawntimer.set_paused(true)
	else:
		$Spawntimer.set_paused(false)
	if(Input.is_action_just_pressed("debug 0")):
		$Spawntimer.stop()

func _on_spawntimer_timeout() -> void:
	createBoulder(0)
	
func createBoulder(instr : int):
	if(get_child_count() < 16):
		var boulder_make = boulder.instantiate()
		add_child(boulder_make)
		print("Boulder Created @ " + str(boulder_make.position))
