extends "res://entities/boulder.gd"

# Big Asteroid
func _ready() -> void:
	exp_value = 0
	points = 3000
	health = 500
	scaleStats()
	
	scale *= 40
	#scale *= Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color(1,1,1,1), 2.5)

	speed *= 0.2
	
# Procs Auto Levelup On Kill
func remove(_normal_enemy: bool = false):
	can_move = false
	Globals.gainPoints(points)
	Globals.gainExp(exp_value,true)
	Globals.enemy_kills += 1
	queue_free()


func _on_timer_timeout() -> void:
	$CollisionArea.disabled = false
