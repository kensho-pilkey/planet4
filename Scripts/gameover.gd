extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("Label").text = str(Gamedata.score)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func change_score(score):
	$Label.text = "Final Score: " + str(score)
