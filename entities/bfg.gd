extends "res://entities/boulder.gd"

func _ready() -> void:
	exp_value = 100
	health = 500
	scale *= 40
	#scale *= Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.5)

	speed *= 0.2
	

func remove(_normal_enemy: bool = false):
	super.remove()
	queue_free()


func _on_timer_timeout() -> void:
	$CollisionArea.disabled = false
