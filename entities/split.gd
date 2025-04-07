extends "res://entities/boulder.gd"
var boulder_make = preload("res://entities/boulder.tscn")


func _ready() -> void:
	exp_value = 2
	$Health.health = 4 
	scale *= 3
	#scale = Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color8(95,95,255,255), 0.5)

	speed = randf_range(0.1,1)
	$CollisionArea.disabled = false

func dead():
	if($Health.health <= 0):
		can_move = false
		Globals.gainPoints(200)
		Globals.enemy_kills += 1
		print("Splitter destroyed with bullets!")
		for i in range(2):
			var boulder = boulder_make.instantiate()
			boulder.global_position = self.position
			boulder.direction = self.direction - 45 + (i % 2 * 90)
			print(i)
			add_sibling(boulder,1)
		Globals.gainExp(2)
		queue_free()
