extends "res://entities/boulder.gd"

var enemyDetected = 0
@onready var baseSpeed = speed

func _ready() -> void:
	exp_value = 5
	health = 20
	scale *= 2
	points = 500
	scaleStats()
	
	modulate.a = 0
	tween.tween_property(self, "modulate", Color.MEDIUM_SPRING_GREEN, 0.5)

	$CollisionArea.disabled = false

func _process(_delta: float) -> void:
	# Followed Path is determined by homing behaviour
	super._process(_delta)
	enemyDetected = !$DetectionArea.get_overlapping_areas().is_empty()
	if(enemyDetected):
		var temp = $DetectionArea.get_overlapping_areas()
		direction = rad_to_deg(get_angle_to(temp[0].global_position))
		speed = baseSpeed * 1.5
	else:
		speed = baseSpeed
	#move_and_slide()

func remove(_normal_enemy: bool = false):
	super.remove()
	queue_free()
