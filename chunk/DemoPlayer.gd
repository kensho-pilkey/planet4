extends CharacterBody2D

func _physics_process(_delta):
	var speed = 200
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	

	#print(global_position)
	move_and_slide()
