extends Control

var score = str(Globals.player_score)

func _ready():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("blur")
	$PanelContainer/VBoxContainer/Score.text = "Score: " + score

func _on_line_edit_text_submitted(new_text: String) -> void:
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
