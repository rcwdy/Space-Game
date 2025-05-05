extends CharacterBody2D
var speed: float
var direction: float
var level = Globals.level

var can_move = true

var exp_value: int
var points: int
var health: int

@onready var tween = create_tween()

func _ready() -> void:
	#add_to_group("Enemy")
	exp_value = 1
	points = 200
	health = 25
	scaleStats()
	
	scale *= 2
	#scale *= Vector2($Health.health,$Health.health)
	modulate.a = 0
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.5)

	$CollisionArea.disabled = false

# Updates Position Every Frame. If can't asteroid removes itself
func _process(_delta: float) -> void:
	if(can_move && health > 0):
		position += speed * Vector2(cos(deg_to_rad(direction)),sin(deg_to_rad(direction)))
	else:
		remove()
	#move_and_slide()

# Relocates itself when travelling offscreen
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

# Code for taking damage
func _on_hitbox_area_entered(_area: Area2D) -> void:
	var damage_taken = (Globals.playerBulletDamage / (Globals.playerBulletCount + 1) + (Globals.playerBulletCount / 2))
	prints("Damage Taken", damage_taken)
	health -= damage_taken
	print("Health Remaining: " + str(health))

# On remove, increases points, player exp, and increases enemy kill count
func remove(normal_enemy: bool = true):
	can_move = false
	Globals.gainPoints(points)
	Globals.gainExp(exp_value)
	Globals.enemy_kills += 1
	if(normal_enemy):
		queue_free()

# Changes base Stats (HP, EXP) based on the current level
func scaleStats():
	health *= pow(1.5,(Globals.level - 1) / 10)
	exp_value *= pow(1 + (Globals.level - 1) / 10,3)
	print("Name:", self, "Health:", health, "Exp:", exp_value)
