extends Node2D

var enemy_scene = load("res://Scenes/enemy.tscn")
@export var score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 3  # Spawn an enemy every 10 seconds
	timer.autostart = true
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_Timer_timeout():
	var enemy_instance = enemy_scene.instantiate()
	get_parent().add_child(enemy_instance)
	enemy_instance.global_position = Vector2(randi_range(-100, 100), randi_range(-100, 100))
	#enemy_instance.global_position = Vector2(0,0)
	enemy_instance.connect("enemy_death", _on_enemy_death)
	
func _on_enemy_death():
	score += 1
	$score.text = "Score: " + str(score)
