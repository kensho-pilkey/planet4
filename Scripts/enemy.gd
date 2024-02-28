extends CharacterBody2D
var speed = 50
var direction: Vector2
var player
var enemy_state: String
var distance
var health = 100

var projectile_scene = load("res://Scenes/enemy_beam.tscn")

var loot = preload("res://Scenes/floating_item.tscn")

var player_nearby

signal enemy_death
	
func _ready():
	player = get_parent().get_node("player")
	add_to_group("enemy")

func _physics_process(_delta):
	distance = player.global_position - global_position
	
	if(health <= 0):
		enemy_state = "dead"
		
	elif player_nearby:
		enemy_state = "attack"
		shoot_projectile()
		
	#Moves enemy towards player
	elif abs(distance.x) + abs(distance.y) < 200:
		direction = distance.normalized()
		velocity = direction * speed
		move_and_slide()
		enemy_state = "walking"
	else:
		enemy_state = "idle"

	play_anim(direction)

func play_anim(dir):
	if enemy_state == "idle":
		$AnimatedSprite2D.play("idle")
	if enemy_state == "walking":
		
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0.5:
				$AnimatedSprite2D.play("e-walk")
			if dir.x < -0.5:
				$AnimatedSprite2D.play("w-walk")
		if abs(dir.x) < abs(dir.y):
			if dir.y > 0.5:
				$AnimatedSprite2D.play("s-walk")
			if dir.y < -0.5:
				$AnimatedSprite2D.play("n-walk")
	if enemy_state == "dead":
		$AnimatedSprite2D.play("s-death")
		await get_tree().create_timer(1).timeout
		emit_signal("enemy_death")
		drop_loot()
		queue_free()

	if enemy_state == "attack":
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0.5:
				$AnimatedSprite2D.play("e-attack")
			if dir.x < -0.5:
				$AnimatedSprite2D.play("w-attack")
		if abs(dir.x) < abs(dir.y):
			if dir.y > 0.5:
				$AnimatedSprite2D.play("s-attack")
			if dir.y < -0.5:
				$AnimatedSprite2D.play("n-attack")
		await get_tree().create_timer(1).timeout

func _on_hitbox_area_entered(area):
	if area.is_in_group("laserbeam"):
		health -= 50

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player_nearby = true
		


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		player_nearby = false;

func shoot_projectile():
	var projectile_instance = projectile_scene.instantiate()
	#Set proj pos and dir to players
	projectile_instance.position = self.position
	if self.direction.x != 0 or direction.y != 0:
		projectile_instance.direction = self.direction
	# Add the projectile to the world
	get_parent().add_child(projectile_instance)
	await get_tree().create_timer(1).timeout
	projectile_instance.queue_free()

func drop_loot():
	var loot_instance = loot.instantiate()
	loot_instance.set_image("coin", 1)
	loot_instance.global_position = global_position
	get_parent().add_child(loot_instance)
