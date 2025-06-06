extends Area2D

func _ready():
	if(Globals.playerBulletHoming):
		$"Homing Area".monitoring = true
		$"Homing Area".monitorable = false

func _process(_delta: float) -> void:
	position += Globals.playerBulletSpeed * Globals.playerBulletSpeedMulti * Vector2(cos(rotation),sin(rotation))
	if(Globals.playerBulletHoming):
		_homing()

# If bullet goes offscreen, bullet is removed
func _on_on_screen_state_screen_exited() -> void:
	print("bullet gone")
	queue_free()

# If bullet hits an enemy, bullet is removed
func _on_area_entered(area: Area2D) -> void:
	if(area.collision_layer == "0000010".bin_to_int()):
		queue_free()

# Homing properties for bullets
func _homing() -> void:
	var temp = $"Homing Area".get_overlapping_areas()
	if(!temp.is_empty()):
		var angle = get_angle_to(temp[0].global_position)
		if(snappedf(angle,0.1) >= 0):
			rotation += 0.05
		else:
			rotation -= 0.05
