extends "res://entities/boulder.gd"

func _ready() -> void:
	exp_value = 20
	health = 150
	points = 2000
	scale *= 2
	
	scaleStats()
	
	#scale *= Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color.GOLDENROD, 0.5)

	speed *= 2
	$CollisionArea.disabled = false

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	## Make boulders have an animation for respawning
	var superparent = get_parent().get_parent()
	# Golden only has a chance to survive after offscreening
	var survive = randi() % 2
	if(survive && superparent != null && superparent.has_node("Locations") && ("newCoords" in superparent)):
		pass
		var relocation = superparent.newCoords(randi_range(0,7))
		print("New Instructions: " + str(relocation))
		global_position.x = relocation.x
		global_position.y = relocation.y
		direction = relocation.z
	else:
		queue_free()

func remove(_normal_enemy: bool = false):
	super.remove()
	queue_free()
