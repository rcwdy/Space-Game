extends Node2D

# This helper node is makes it the parent can screen wrap
# In other words, when the parent goes off the right of the screen they appear on the left and vice versa

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if($"..".position.x >= Globals.screenRes.x + _get_image_size().x):
		$"..".position.x = -_get_image_size().x/2
	if($"..".position.x <= -20 - _get_image_size().x):
		$"..".position.x = Globals.screenRes.x + _get_image_size().x/2
		
	if($"..".position.y >= Globals.screenRes.y + _get_image_size().y):
		$"..".position.y = -_get_image_size().y/2
		
	if($"..".position.y <= -20 - _get_image_size().y):
		$"..".position.y = Globals.screenRes.y + _get_image_size().y/2
		
	
func _get_image_size() -> Vector2:
	var size: Vector2 = ($"../Sprite".texture.get_size())
	size.x *= $"../Sprite".scale.x
	size.y *= $"../Sprite".scale.x
	return size
