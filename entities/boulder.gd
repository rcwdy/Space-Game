extends CharacterBody2D
var speed
var direction
var tween = Tween
#var can_kill = false

func _ready() -> void:
	$Health.health = 2 
	scale = Vector2($Health.health,$Health.health)
	modulate.a = 0
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,1), 1)
	
	position = Vector2(randi_range(-80,80),randi_range(-80,80))
	speed = randf_range(0.1,1)
	direction = randi_range(0,360)
	$CollisionArea.disabled = false
	
func _process(delta: float) -> void:
	position += speed * Vector2(cos(deg_to_rad(direction)),sin(deg_to_rad(direction)))
	move_and_slide()
		


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#if(can_kill):
	print("dead")
	queue_free()
