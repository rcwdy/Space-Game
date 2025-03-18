extends CharacterBody2D
var moveSpeed = 0
var turnSpeed = 0
var health

var degree = 0 
var bullet = preload("res://entities/bullet.tscn")

func _ready() -> void:
	print(DisplayServer.window_get_size().x)
	$Health.health = 20
	$Fire.play("Blast!")

func _shoot():
	var shot = bullet.instantiate()
	add_child(shot)
	print(str(shot) + "Position: " + str(shot.global_position))

func _process(_delta: float) -> void:
	health = $Health.health
	
	move_and_slide()
	updateMoveSpeed()
	updateTurnSpeed()
	if(Input.is_action_just_pressed("Schüt")):
		_shoot()
		
	if(Input.is_action_pressed("ui_left")): 
		degree += turnSpeed
	elif(Input.is_action_pressed("ui_right")):
		degree += turnSpeed
	## Update This
	position += moveSpeed * Vector2(cos(rotation),sin(rotation))
	moveSpeed = snappedf(moveSpeed, 0.05)
	turnSpeed = snappedf(turnSpeed, 0.05)
	
	rotation_degrees = degree
	degree = rotation_degrees
	$FireParticles.set_direction(Vector2(cos(rotation),sin(rotation)))
	$FireParticles.set_rotation(degree)
	#print($FireParticles.direction)

func updateMoveSpeed():
	if(Input.is_action_pressed("ui_up")):
		if(moveSpeed < 5):
			moveSpeed += 0.1
	elif(Input.is_action_pressed("ui_down")):
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
	if(moveSpeed >= 5):
		$Fire.show()
		$FireParticles.emitting = true
		if(!$RocketSound.is_playing()):
			print("Hello")
			$RocketSound.play()
	else:
		$Fire.hide()
		$FireParticles.emitting = false
		$RocketSound.stop()
func updateTurnSpeed():
	if(Input.is_action_pressed("ui_right")):
		if(turnSpeed < 5):
			turnSpeed += 0.25
	elif(Input.is_action_pressed("ui_left")):
		if(turnSpeed > -5):
			turnSpeed -= 0.25
	else:
		if(turnSpeed == 0):
			return
		elif(turnSpeed > 0):
			turnSpeed *= 0.2
		else:
			turnSpeed *= 0.2
	
func _on_hitbox_body_entered(body: Node2D) -> void:
	print("Ouch")
	$Health.health -= 1
	body.queue_free()

func _on_collection_area_entered(area: Area2D) -> void:
	print("Good")
	
