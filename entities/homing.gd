extends "res://entities/boulder.gd"

var enemyDetected = 0

func _process(_delta: float) -> void:
	if(can_move):
		position += speed * Vector2(cos(deg_to_rad(direction)),sin(deg_to_rad(direction)))
	dead()
	enemyDetected = !$DetectionArea.get_overlapping_areas().is_empty()
	if(enemyDetected):
		var temp = $DetectionArea.get_overlapping_areas()
		direction = rad_to_deg(get_angle_to(temp[0].global_position))
	#move_and_slide()
