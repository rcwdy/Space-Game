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

func _on_spawntimer_timeout() -> void:
	createBoulder(0)
	
func createBoulder(instr : int):
	if(get_child_count() < 16):
		var boulder_make = boulder.instantiate()
		add_child(boulder_make,1)
		#print("Boulder Created @ " + str(boulder_make.position))
