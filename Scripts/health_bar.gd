extends TextureProgressBar


func _ready():
	set_health(get_parent().health) 
	

func _process(delta):
	pass

func set_health(health):
	value = health
	$health.text = str(health)+ " / 1000"
	if value < 0:
		value = 0
