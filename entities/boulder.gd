extends CharacterBody2D
var speed
var direction
var tween = Tween
func _ready() -> void:
	$Health.health = 2 
	scale = Vector2(0,0)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2($Health.health,$Health.health), 1)
	
	position = Vector2(randi_range(-80,80),randi_range(-80,80))
	speed = randf_range(0.1,1)
	direction = randi_range(0,360)
	print(acos(direction))
	print(cos(direction))
	#move_and_slide()
	
func _physics_process(delta: float) -> void:
	position += speed * Vector2(cos(deg_to_rad(direction)),sin(deg_to_rad(direction)))
	move_and_slide()
	if(global_position.x >= 660 or global_position.x <= -20 or global_position.y >= 500 or global_position.y <= -20):
		print('dead')
		queue_free()
		
