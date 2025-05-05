extends Control

signal upgrade_selected(upgrade_id: String)

# Buttons for upgrades
@onready var buttons := [
	$PanelContainer/HBoxContainer/Button,
	$PanelContainer/HBoxContainer/Button2,
	$PanelContainer/HBoxContainer/Button3
]

# Full llist of available upgrades
var all_upgrades: Array[Dictionary] = []
# Tracks how many times each upgrade has been used
var upgrade_use_counts: Dictionary = {}
# Stores the options currently shown to the player
var current_choices: Array[Dictionary] = []

# Lets the function "_on_upgrade_pressed" know which button was pressed
func _ready():
	for button in buttons:
		button.pressed.connect(_on_upgrade_pressed.bind(button))


func open(upgrades: Array[Dictionary], use_counts: Dictionary):
	all_upgrades = upgrades
	upgrade_use_counts = use_counts
	# Chooses random upgrades to display to the player
	current_choices = _pick_random_upgrades(3)
	## Game crashed when duplicate upgrade is loaded
	# Changes the icon of the buttons to display the proper power up
	for i in range(buttons.size()):
		buttons[i].texture_normal = current_choices[i]["icon"]

	# Pause the game, and makes the upgrade menu visible
	visible = true
	$AnimationPlayer2.play("blur")
	get_tree().paused = true


func _on_upgrade_pressed(button: TextureButton):
	var index = buttons.find(button)
	var selected= current_choices[index]

	var id = selected["id"]
	# Creates a usage count tracker per power up and adds to it
	if not upgrade_use_counts.has(id):
		upgrade_use_counts[id] = 0
	upgrade_use_counts[id] += 1

	# Unpauses the game and makes the upgrade menu invisible
	visible = false
	get_tree().paused = false

	# Tells the game what upgrade was chosen
	emit_signal("upgrade_selected", id)

# Selects random power ups that haven't been chosen the max amount of times
func _pick_random_upgrades(count: int) -> Array[Dictionary]:
	var pool: Array[Dictionary] = []

	# Checks an upgrades max usages and amount of usages.
	for upgrade in all_upgrades:
		var id = upgrade["id"]
		var maxu = upgrade.get("max_uses", -1)
		var used = upgrade_use_counts.get(id, 0)

		if maxu == -1 or used < maxu:
			pool.append(upgrade)

	pool.shuffle()
	return pool.slice(0, count)
