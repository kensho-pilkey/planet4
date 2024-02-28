extends Area2D

var speed = 400  # Adjust as necessary
var direction = Vector2.RIGHT  # Default direction

func _ready():
	add_to_group("enemybeam")
	
func _process(delta):
	position += direction.normalized() * speed * delta

