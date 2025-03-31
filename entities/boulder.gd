extends CharacterBody2D
var speed
var direction: int
var can_move = true
@onready var tween = create_tween()

func _ready() -> void:
	$Health.health = 2 
	scale = Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color(1,1,1,1), 1)
	
	#position = Vector2(randi_range(-80,80),randi_range(-80,80))
	speed = randf_range(0.1,1)
	#direction = randi_range(0,360)
	$CollisionArea.disabled = false
	#print("Name:" + str(self) + str(Vector2(cos(deg_to_rad(direction)),sin(deg_to_rad(direction)))))
	
func _process(_delta: float) -> void:
	if(can_move):
		position += speed * Vector2(cos(deg_to_rad(direction)),sin(deg_to_rad(direction)))
	dead()
	#move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#if(can_kill):
	#print("dead")
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	$Health.health -= Globals.playerBulletDamage
	print("Health Remaining: " + str($Health.health))

func dead():
	if($Health.health <= 0):
		can_move = false
		Globals.gainPoints(200)
		Globals.enemy_kills += 1
		print("Destroyed with bullets!")
		#can_move = false
		queue_free()
