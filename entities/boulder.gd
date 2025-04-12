extends CharacterBody2D
var speed = 0.5
var direction: float
var can_move = true
var exp_value
var level = Globals.level
@onready var tween = create_tween()

func _ready() -> void:
	exp_value = 1
	$Health.health = 2
	scale *= 2
	#scale *= Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.5)

	speed = randf_range(0.5,1) * (1 + 0.1 * (level - 1))
	$CollisionArea.disabled = false

func _process(_delta: float) -> void:
	if(can_move):
		position += speed * Vector2(cos(deg_to_rad(direction)),sin(deg_to_rad(direction)))
	dead()
	#move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	## Make boulders have an animation for respawning
	var superparent = get_parent().get_parent()
	if(superparent != null && superparent.has_node("Locations") && ("newCoords" in superparent)):
		pass
		var relocation = superparent.newCoords(randi_range(0,7))
		print("New Instructions: " + str(relocation))
		global_position.x = relocation.x
		global_position.y = relocation.y
		direction = relocation.z
	else:
		queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	$Health.health -= Globals.playerBulletDamage
	print("Health Remaining: " + str($Health.health))

func dead():
	if($Health.health <= 0):
		can_move = false
		Globals.gainPoints(200)
		Globals.enemy_kills += 1
		Globals.gainExp(exp_value)
		print("Destroyed with bullets!")
		queue_free()
