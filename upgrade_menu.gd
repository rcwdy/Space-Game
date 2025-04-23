extends Control

signal upgrade_selected(upgrade_id: String)

@onready var buttons := [
	$PanelContainer/HBoxContainer/Button,
	$PanelContainer/HBoxContainer/Button2,
	$PanelContainer/HBoxContainer/Button3
]

var all_upgrades: Array[Dictionary] = []
var upgrade_use_counts: Dictionary = {}
var current_choices: Array[Dictionary] = []

func _ready():
	for button in buttons:
		button.pressed.connect(_on_upgrade_pressed.bind(button))

func open(upgrades: Array[Dictionary], use_counts: Dictionary):
	all_upgrades = upgrades
	upgrade_use_counts = use_counts
	
	current_choices = _pick_random_upgrades(3)
	## Game crashed when duplicate upgrade is loaded
	for i in range(buttons.size()):
		buttons[i].texture_normal = current_choices[i]["icon"]

	visible = true
	$AnimationPlayer2.play("blur")
	get_tree().paused = true

func _on_upgrade_pressed(button: TextureButton):
	var index = buttons.find(button)
	var selected= current_choices[index]

	var id = selected["id"]
	if not upgrade_use_counts.has(id):
		upgrade_use_counts[id] = 0
	upgrade_use_counts[id] += 1

	visible = false
	get_tree().paused = false

	emit_signal("upgrade_selected", id)

func _pick_random_upgrades(count: int) -> Array[Dictionary]:
	var pool: Array[Dictionary] = []

	for upgrade in all_upgrades:
		var id = upgrade["id"]
		var maxu = upgrade.get("max_uses", -1)
		var used = upgrade_use_counts.get(id, 0)

		if maxu == -1 or used < maxu:
			pool.append(upgrade)

	pool.shuffle()
	return pool.slice(0, count)
