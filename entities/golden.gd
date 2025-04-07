extends "res://entities/boulder.gd"

func _ready() -> void:
	exp_value = 20
	$Health.health = 7
	scale *= 3
	#scale *= Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color.GOLDENROD, 0.5)

	speed = randf_range(0.1,1) * 2
	$CollisionArea.disabled = false

func dead():
	if($Health.health <= 0):
		can_move = false
		Globals.gainPoints(1000)
		Globals.gainExp(20)
		Globals.enemy_kills += 1
		print("Destroyed with bullets!")
		queue_free()
