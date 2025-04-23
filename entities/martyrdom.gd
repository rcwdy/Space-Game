extends "res://entities/boulder.gd"
var bullet_make = preload("res://entities/bullet.tscn")

func _ready() -> void:
	exp_value = 3
	health = 15
	scale *= 2
	points = 400
	scaleStats()

	modulate.a = 0
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.5)

	speed *= 1.5
	$CollisionArea.disabled = false

func remove(_normal_enemy: bool = false):
	super.remove()
	for i in range(4):
		var bullet = bullet_make.instantiate()
		bullet.set_modulate(self.modulate)
		bullet.set_collision_layer(("0010000").bin_to_int())
		bullet.set_collision_mask("0000001".bin_to_int())
		
		bullet.global_position = $Markers.get_child(i).global_position
		bullet.rotation_degrees = rad_to_deg(self.get_angle_to($Markers.get_child(i).global_position))
		#print("Angle to Point" + str(self.get_angle_to($Markers.get_child(i).position)))

		print(bullet)
		print(bullet.rotation_degrees)
		#print(bullet)
		add_sibling(bullet,1)
	queue_free()
