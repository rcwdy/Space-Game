extends "res://entities/boulder.gd"
var boulder_make = preload("res://entities/boulder.tscn")


func _ready() -> void:
	exp_value = 2
	health = 40
	points = 400
	scale *= 3
	#scale = Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color.SKY_BLUE, 0.5)

	speed = randf_range(0.5,1) * (1 + 0.1 * (Globals.level - 1)) * 0.8
	$CollisionArea.disabled = false

func remove(normal_enemy: bool = false):
	super.remove()
	var spawn_count = 2 + (level / 10)
	for i in range(spawn_count):
		var boulder = boulder_make.instantiate()
		boulder.global_position = self.position
		boulder.direction = self.direction - (180/(spawn_count * 2)) + (i % spawn_count * (180/spawn_count))
		print(i)
		add_sibling(boulder,1)
	queue_free()
