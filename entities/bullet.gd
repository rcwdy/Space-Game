extends Area2D
var target = Vector2(0,0)

func _ready():
	if(Globals.playerBulletHoming):
		$"Homing Area".monitoring = true
		$"Homing Area".monitorable = false

func _process(_delta: float) -> void:
	position += Globals.playerBulletSpeed * Globals.playerBulletSpeedMulti * Vector2(cos(rotation),sin(rotation))

func _on_on_screen_state_screen_exited() -> void:
	#print("bullet gone")
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	#print(area)
	#print("hit")
	#print("Baka")
	queue_free()

func _track(area: Area2D):
	if(target != Vector2(0,0)):
		pass

func _on_homing_area_area_entered(area: Area2D) -> void:
	if(target == Vector2(0,0)):
		target = area.global_position
		look_at(area.global_position)
	else:
		if(self.global_position.distance_squared_to(target) > self.global_position.distance_squared_to(target)):
			print("New Target Found!")
			target = area.global_position
			look_at(area.global_position)
	print(area.global_position)
	print("Difference: " + str(self.global_position - area.global_position))
	print("Rotate Difference: " + str(self.global_position - area.global_position))
