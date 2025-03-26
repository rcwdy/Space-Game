extends Area2D
var speed 

func _ready() -> void:
	speed = 6
	print(speed)

func _process(_delta: float) -> void:
	position += speed * Vector2(cos(rotation),sin(rotation))

func _on_on_screen_state_screen_exited() -> void:
	#print("bullet gone")
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	#print(area)
	queue_free()
	
