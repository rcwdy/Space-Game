extends "res://entities/boulder.gd"

var enemyDetected = 0

func _ready() -> void:
	exp_value = 5
	health = 20
	scale *= 2
	#scale *= Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color.MEDIUM_SPRING_GREEN, 0.5)

	speed = randf_range(0.5,1) * (1 + 0.1 * (level - 1))
	$CollisionArea.disabled = false

func _process(_delta: float) -> void:
	super._process(_delta)
	enemyDetected = !$DetectionArea.get_overlapping_areas().is_empty()
	if(enemyDetected):
		var temp = $DetectionArea.get_overlapping_areas()
		direction = rad_to_deg(get_angle_to(temp[0].global_position))
	#move_and_slide()

func remove(normal_enemy: bool = false):
	super.remove()
	queue_free()
