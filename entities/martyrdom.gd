extends "res://entities/boulder.gd"
var bullet_make = preload("res://entities/bullet.tscn")

func _ready() -> void:
	exp_value = 3
	$Health.health = 1
	scale *= 2
	#scale *= Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color.CRIMSON, 0.5)

	speed = randf_range(0.1,1)
	print("Angle to North" + str(rad_to_deg(self.get_angle_to($Markers/North.global_position))))
	print("Angle to South" + str(rad_to_deg(self.get_angle_to($Markers/South.global_position))))
	print("Angle to East" +  str(rad_to_deg(self.get_angle_to($Markers/West.global_position))))
	print("Angle to West" +  str(rad_to_deg(self.get_angle_to($Markers/East.global_position))))
	$CollisionArea.disabled = false

func dead():
	if($Health.health <= 0):
		can_move = false
		Globals.gainPoints(400)
		Globals.enemy_kills += 1
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
		Globals.gainExp(3)
		queue_free()
