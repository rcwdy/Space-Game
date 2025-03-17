extends Camera2D

func _ready():
	print(get_parent())

func _process(delta):
	print($"..".moveSpeed)
	offset.x = $"..".moveSpeed * 6
	offset = Vector2(cos($"..".rotation_degrees) * $"..".moveSpeed * 48, sin($"..".rotation_degrees)* $"..".moveSpeed * 48)
	rotation_degrees = $"..".rotation_degrees
