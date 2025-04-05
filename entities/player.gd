extends CharacterBody2D
var moveSpeed = 0
var maxMoveSpeed = 5
var turnSpeed = 0

var degree = 0 
var bullet = preload("res://entities/bullet.tscn")

func _ready() -> void:
	$ShootCD.wait_time = Globals.playerShootSpeed
	#print(DisplayServer.window_get_size().x)
	$Fire.play("Blast!")

func _shoot():
	if($ShootCD.is_stopped()):
	# Creates bullet in front of the ship.
		var array = []
		for i in range(Globals.playerBulletCount / 2):
			var shot = bullet.instantiate()
			shot.position = $ShootArea.global_position 
			shot.rotation_degrees = self.rotation_degrees + 5 * i
			shot.scale *= Globals.playerBulletSize
			array.append(shot)
		for i in range(Globals.playerBulletCount / 2):
			var shot = bullet.instantiate()
			shot.position = $ShootArea.global_position 
			shot.rotation_degrees = self.rotation_degrees - 5 * i
			shot.scale *= Globals.playerBulletSize
			array.append(shot)
		
		var shot = bullet.instantiate()
		shot.position = $ShootArea.global_position
		shot.rotation = self.rotation
		shot.scale *= Globals.playerBulletSize
		array.append(shot)
		
		for i in range(array.size()):
			add_sibling(array[i])
		$ShootCD.start()
	#else:
		#print("You can not shoot yet!")

# Updates ran every frame
func _process(_delta: float) -> void:
	if(!$DashAttackCD.is_stopped()):
		print($DashAttackCD.time_left)
	
	move_and_slide()
	updateMoveSpeed()
	updateTurnSpeed()
	updatePlayerAction()
	updateParticles()
	
	rotation_degrees = degree
	degree = rotation_degrees
	$ShootCD.wait_time = Globals.playerShootSpeed


func updateMoveSpeed():
	if(Input.is_action_pressed("Up")):
		if(moveSpeed < maxMoveSpeed):
			moveSpeed += 0.1
	elif(Input.is_action_pressed("Down")):
		if(moveSpeed > 0):
			moveSpeed -= 0.2
		elif(moveSpeed > -2):
			moveSpeed -= 0.1
	else:
		if(moveSpeed == 0):
			return
		elif(moveSpeed > 0):
			moveSpeed -= 0.125
		else:
			moveSpeed += 0.125
	if(moveSpeed >= maxMoveSpeed):
		$Fire.show()
		$Particles/FireParticles.emitting = true
		if(!$RocketSound.is_playing()):
			print("Fast")
			$RocketSound.play()
	else:
		$Fire.hide()
		$Particles/FireParticles.emitting = false
		$RocketSound.stop()
func updateTurnSpeed():
	if(Input.is_action_pressed("Right")):
		if(turnSpeed < 5):
			turnSpeed += 0.25
	elif(Input.is_action_pressed("Left")):
		if(turnSpeed > -5):
			turnSpeed -= 0.25
	else:
		if(turnSpeed == 0):
			return
		elif(turnSpeed > 0):
			turnSpeed *= 0.2
		else:
			turnSpeed *= 0.2
func updatePlayerAction():
	if(Globals.autofire):
		if(Input.is_action_pressed("Schüt")):
			_shoot()
	else:
		if(Input.is_action_just_pressed("Schüt")):
			_shoot()
		
	if(Input.is_action_pressed("Left")): 
		degree += turnSpeed
	elif(Input.is_action_pressed("Right")):
		degree += turnSpeed
	## Update This
	position += moveSpeed * Vector2(cos(rotation),sin(rotation))
	moveSpeed = snappedf(moveSpeed, 0.05)
	turnSpeed = snappedf(turnSpeed, 0.05)
func updateParticles():
	$Particles/FireParticles.set_direction(Vector2(cos(rotation),sin(rotation)))
	$Particles/FireParticles.set_rotation(degree)

func _on_hitbox_body_entered(_body: Node2D) -> void:
	print("Ouch")
	if has_node("FireParticles") and $DashAttackCD.is_stopped() and Globals.playerDashAttack:
		var particles = get_node("FireParticles")
		if particles.emitting:
			_body.queue_free()
			$DashAttackCD.start()
			get_tree().change_scene_to_file("res://game_over.tscn")  # Trigger game over scene

			

	
func _on_collection_area_entered(_area: Area2D) -> void:
	print("Good")
