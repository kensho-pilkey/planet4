extends CharacterBody2D

var speed = 50

var player_state

var projectile_scene = load("res://Scenes/laserbeam.tscn")

var enemy_scene = load("res://Scenes/enemy.tscn")

var inventory

var score: int = 0

var direction

var temp_dir = Vector2(0,0)

@export var health = 1000

func _ready():
	inventory = get_node("inventory_ui")
	

func _physics_process(_delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") # replace with ("left", "right", "up", "down") if you like "WASD" controls
	if direction.x != 0 or direction.y != 0:
		temp_dir = direction
		
	if Input.is_action_just_pressed("drop_item"):
		inventory.remove_item()
	if Input.is_action_just_pressed("open-inv"):  
		open_inventory()
	if Input.is_action_just_pressed("shoot"): 
		shoot_projectile()
	if health <= 0:
		player_state = "dead"	
	elif direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		

	velocity = direction * speed 
	move_and_slide()
	
	if player_state == "idle":
		play_anim(temp_dir)
	else:
		play_anim(direction)
		
func play_anim(dir):
	
	if player_state == "idle":
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0.5:
				$AnimatedSprite2D.play("e-idle")
			if dir.x < -0.5:
				$AnimatedSprite2D.play("w-idle")
		if abs(dir.x) < abs(dir.y):
			if dir.y > 0.5:
				$AnimatedSprite2D.play("s-idle")
			if dir.y < -0.5:
				$AnimatedSprite2D.play("n-idle")
		#$AnimatedSprite2D.pause()
	if player_state == "walking":
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
	if player_state == "dead":
		#var final_score = get_parent().get_node("E_spawner").score
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(1).timeout
		#var game_over_scene = preload("res://Scenes/gameover.tscn")
		#var game_over_instance = game_over_scene.instantiate()
		#game_over_instance.change_score(final_score)
		#get_tree().change_scene_to_packed()
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
		
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

func player():
	pass


func _on_hitbox_area_entered(area):
	if area.is_in_group("enemybeam"):
		if health > 0:
			health -= 3
			$health_bar.set_health(health)
	if area.is_in_group("item"):
		inventory.add_item(str(area.get_img_name()), area.get_item_count())
		


func open_inventory():
	inventory.toggle_inventory()
