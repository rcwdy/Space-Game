extends Node

var json_data = {}
var path = "res://spawns.json"

func _ready() -> void:
	json_data = json_read(path)
	print(json_data)

func json_read(file_path : String):
	if FileAccess.file_exists(file_path):
		var dataFile = FileAccess.open(file_path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("error reading file")
	else:
		print("File Not Found!")
